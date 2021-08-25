source ./hadoop-common.sh

# Get all required hadoop config files
sudo cp ./hadoop-config-files/* $HADOOP_HOME/etc/hadoop

# To start HDFS, and YARN as resourcemanager
hdfs namenode -format
start-dfs.sh
start-yarn.sh