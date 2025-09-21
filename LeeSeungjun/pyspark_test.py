from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("PrefaceTest").getOrCreate()
df = spark.createDataFrame([(1, "Preface"), (2, "Ready")], ["id", "msg"])
df.show()
spark.stop()