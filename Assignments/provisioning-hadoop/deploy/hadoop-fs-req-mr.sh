source hadoop-common.sh

hadoop fs -mkdir /user
hadoop fs -mkdir /user/dholmgren
hadoop fs -mkdir /user/dholmgren/input
hadoop fs -put $HADOOP_HOME/*.txt /user/dholmgren/input