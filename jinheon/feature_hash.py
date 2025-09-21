from pyspark.ml.feature import FeatureHasher
from pyspark.sql import SparkSession


def get_sample():
    data = [
        (2.1, True, "1", "fox"),
        (2.1, False, "2", "gray"),
        (3.3, False, "2", "red"),
        (4.4, True, "4", "fox"),
    ]
    cols = ["number", "boolean", "string_number", "string"]

    return data, cols


if __name__ == "__main__":
    spark = (
        SparkSession.builder.appName("FeatureHasher")  # appName (builder.appName)
        .enableHiveSupport()  # enableHiveSupport
        .getOrCreate()  # getOrCreate
    )

    data, cols = get_sample()

    df = spark.createDataFrame(data, cols)

    hasher = FeatureHasher()
    hasher.setInputCols(cols)
    hasher.setOutputCol("feature")
    featurized = hasher.transform(df)
    featurized.show(truncate=Fase)
