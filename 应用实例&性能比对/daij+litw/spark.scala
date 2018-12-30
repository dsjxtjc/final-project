# 第一步，导入数据集

import org.apache.spark.ml.evaluation.RegressionEvaluator
import org.apache.spark.ml.recommendation.ALS

case class Rating(userId: Int, movieId: Int, rating: Float, timestamp: Long)

def parseRating(str: String): Rating = {
  val fields = str.split(",")
  assert(fields.size == 4)
  Rating(fields(0).toInt, fields(1).toInt, fields(2).toFloat, fields(3).toLong)
}

val input = sc.textFile("hdfs:///dsjxtjc/2018211082/ratings.csv")
var ratings = input.map(parseRating).toDF()


# 第二步，划分训练集和测试集
val Array(training, test) = ratings.randomSplit(Array(0.8, 0.2))

val als = new ALS().setMaxIter(5).setRegParam(0.01).setUserCol("userId").setItemCol("movieId").setRatingCol("rating")

val model = als.fit(training)
val predictions = model.transform(test)

val evaluator = new RegressionEvaluator().setMetricName("rmse").setLabelCol("rating").setPredictionCol("prediction")

val rmse = evaluator.evaluate(predictions.na.drop())


# 第三步，选择最佳参数
val evaluations =
     for (rank   <- Seq(5,10，30);
         regParam  <- Seq(1.0,0.02，0.0001);
      alpha  <- Seq(1.0,5.0，10.0))
      yield {
      val als = new ALS().setRank(rank).setRegParam(regParam).setAlpha(alpha).setMaxIter(20).setUserCol("userId").setItemCol("movieId").setRatingCol("rating")
     val model = als.fit(training)
     val predictions = model.transform(test)
     val evaluator = new RegressionEvaluator().setMetricName("rmse").setLabelCol("rating").setPredictionCol("prediction")
     val rmse = evaluator.evaluate(predictions.na.drop())
     (rmse,(rank,regParam,alpha))
     }

evaluations.show()


# 第四步，在最佳参数下构造推荐系统
import org.apache.spark.ml.recommendation._
import scala.util.Random
import org.apache.spark.sql.DataFrame

var model = new ALS().setSeed(Random.nextLong()).setImplicitPrefs(true).setRank(10).setRegParam(0.01).setAlpha(1.0).setMaxIter(10).setUserCol("userId").setItemCol("movieId").setPredictionCol("prediction").fit(ratings)

def makeRecommendations(model:ALSModel,userID:Int,howMany:Int): DataFrame = {
val toRecommend = model.itemFactors.select($"id".as("movieId")).withColumn("userId",lit(userID))
model.transform(toRecommend).select("movieId","prediction").orderBy($"prediction".desc).limit(howMany)}

val topRecommendations = makeRecommendations(model,100,10)


