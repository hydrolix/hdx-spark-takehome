#!/bin/bash

if [ "$1" = "spark-shell" ]; then
    /opt/spark/bin/spark-shell --conf spark.sql.catalog.hdx=io.hydrolix.connectors.spark.HdxTakeHomeCatalog
else
    /bin/bash
fi
