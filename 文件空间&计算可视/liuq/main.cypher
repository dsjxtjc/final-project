// 1.create NameNode
CREATE (n:NameNode {id:0, name:"thumm01"})
RETURN n

// 0.load Data
LOAD CSV WITH HEADERS FROM "file:///datanode.csv" AS line 
MERGE (n:DataNode {id:line.id, name:line.name}) 
RETURN n

LOAD CSV WITH HEADERS FROM "file:///file.csv" AS line 
MERGE (n:File {id:line.id, name:line.name}) 
RETURN n

LOAD CSV WITH HEADERS FROM "file:///block.csv" AS line 
MERGE (n:Block {id:line.id, file_id:line.file_id, name:line.name,
datanode_realpath:line.datanode_realpath, datanode_id:line.datanode_id, 
realpath:line.realpath, types_permissions:line.types_permissions, link:line.link,
ownership:line.ownership, group_ownership:line.group_ownership, size:line.size,
month:line.month, day:line.day, time:line.time,
verbose:line.verbose
}) 
RETURN n


/*
CREATE (n:NameNode {id:0})
WITH n

// relationship
MATCH (n) WHERE n.id=0
SET n.name="thumm01" 
RETURN n */


// 2. NameNode和DataNode的关系
MATCH (d:DataNode), (n:NameNode) 
WHERE n.id=0 
CREATE (d)-[:controlMSG {type: "server_state"}]->(n) 
//MATCH (n:NameNode),(d:DataNode) 
CREATE (n)-[:controlMSG {type: "instructions"}]->(d)
RETURN n, d

// 3.DataNode和DataNode之间
MATCH (n1:DataNode),(n2:DataNode)
WHERE n1.id <> n2.id
CREATE (n1)-[:dataMSG{type:"internet"}]->(n2)
RETURN n1,n2

// 4.DataNode和block间
MATCH (datanode:DataNode), (block:Block) 
WHERE datanode.name=block.datanode_id
CREATE (datanode)-[:dataMSG {type:"1"}]->(block), (block)-[:dataMSG {type:"2"}]->(datanode)
RETURN datanode, block

// 5.file和block之间
MATCH (file:File), (block:Block) 
WHERE file.name=block.file_id
CREATE (file)-[:dataMSG {type:"split_to"}]->(block), (block)-[:dataMSG {type:"merge_to"}]->(file)
RETURN file, block


// 6.全部
MATCH p=()-->() 
RETURN p

// 7.查询文件（并解释查找过程）
EXPLAIN MATCH (f:File)-[m1:dataMSG]-(l)-[m2:dataMSG]-(d:DataNode)
WHERE f.name="wccd"
RETURN d,l,f

// 8.查询文件在那台机器上有相应的块
MATCH (f:File)-[m1:dataMSG]-(l)-[m2:dataMSG]-(d:DataNode)
WHERE f.name="wccd" AND d.name="thumm02"
RETURN d,l,f


// 100.清除数据库
MATCH (n) DETACH DELETE n








