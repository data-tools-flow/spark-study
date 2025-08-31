# 크기가 서로 다른 데이터를 조인하는 경우
## broadcast() 를 사용하지 않은 경우
- 정렬 병합 조인(Sort-Merge Join, 셔플 조인) 방식
- 이 과정에서 전체 노드 사이에서 두 데이터 모두 네트워크 통신을 유발하는 셔플(shuffle)이 발생합니다. 즉, 두 데이터가 전체 노드 간 통신을 해야하기 때문에 큰 비용이 발생하고 이는 데이터의 크기가 클수록, 노드의 개수가 많을 수록 더 큰 비용이 발생합니다.
## broadcast() 을 사용한 경우
- 일반적으로 크기가 작은 데이터에 적용합니다.
- 노드 기준 큰 데이터는 로컬에 가지고 있고 작은 데이터를 미리 복사해서 분배받습니다.(최초 1회 작업)
- 각각의 노드 사이의 통신 없이 로컬에서 작업이 이루어지기때문에 비용을 줄이고 처리 속도를 높일 수 있습니다.

``` python
# 사용예시
parsed_df = ... # 크기가 큼

broadcasted_df = broadcast(sector_df) # 상대적으로 크기가 작은 데이터프레임에 broadcast() 적용

joined_df = parsed_df.join(
        broadcasted_df,
        parsed_df.stock_code == broadcasted_df.stock_code,
        "inner"
    )
```
### 참조
- https://ingu627.github.io/spark/spark_db11/
- https://quackstudy.tistory.com/entry/Spark-SparkSQL

# 스파크 스트리밍 환경에서 집계와 워터마크
- window 의 상태를 관리한다
- 스트리밍 환경에서 일정 주기로 집계를 하는 경우 워터마크가 문법적으로 필수는 아니지만 안정적인 운영을 위해 꼭 필요함
## withWatermark() 를 사용하지 않는 경우
- 스파크가 정해진 주기로 집계를 하지만 해당 주기를 벗어나는 데이터도 있을 지 몰라 집계 결과를 메모리에 유지하고 있음(메모리 누수)
- 결국 시간이 지나면 OutOfMemoryError 발생

## withWatermark() 를 사용하는 경우
- withWatermark() 에 지정한 시간이 지나면 집계 결과를 출력하고 상태를 마감함(메모리에서 삭제)

``` python
# 사용예시
window_agg_df = joined_df \
        .withWatermark("timestamp", "1 minute") \
        .groupBy(
            window("timestamp", "30 seconds"), # 30초 주기로 집계
            ...
        )

```
### 참조
- https://quackstudy.tistory.com/entry/Spark-%EC%8A%A4%ED%8C%8C%ED%81%AC-%EC%8A%A4%ED%8A%B8%EB%A6%AC%EB%B0%8D%EC%9D%98-%EC%9D%B4%EB%B2%A4%ED%8A%B8-%EC%8B%9C%EA%B0%84-%EC%B2%98%EB%A6%AC%EC%99%80-Watermark