import dlt

# stream table
@dlt.table(
    name='demo_stream_tbe'
)
def demo_stream_tbl():
    df=spark.readStream.table('first_catalog.bronze.`20251112_nse`')
    return df

# materaial view
@dlt.table(
    name='demo_mat_tbl'
)
def demo_mat_view():
    df=spark.read.table('first_catalog.bronze.`20251112_nse`')
    return df

# temporary view

@dlt.view(
    name='demo_tmp_view'
)
def demo_tmp_view():
    df=spark.read.table('first_catalog.bronze.`20251112_nse`')
    return df

@dlt.view(
    name='demo_tmp_stm_view'
)
def demo_tmp_stm_view():
    df=spark.readStream.table('first_catalog.bronze.`20251112_nse`')
    return df


