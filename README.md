# Take-Home Assignment: Implement a Custom DataSource V2 Reader with Directory-Based Partitioning and Optimized String Searching

## Overview
In this assignment, you will implement a custom Spark DataSource V2 reader for a custom file format (`.log`) that includes directory-based partitioning. You will also enhance the reader to support filter pushdown for string searches. This assignment will assess your ability to understand Spark’s DataSource V2 implementation.

## Part 1: Basic Implementation

### Objective
Implement a custom Spark DataSource V2 reader for a `.log` file format with directory-based partitioning. The `.log` file format is simple, where each line contains a record of two values separated by a pipe (`|`): an integer (representing an epoch timestamp) and a string.

### Tasks

1. **Implement a DataSource V2 Reader with Directory-Based Partitioning:**
   - **Directory-Based Partitioning:** Your reader should treat each directory containing a `.log` file as a separate partition. For example, if there are three directories (`dir1`, `dir2`, `dir3`), each containing a file named `partition.log`, your reader should create three partitions, with each partition reading data from one of these directories.
   - **Row Parsing:** Each `partition.log` file within the directories should be read line by line, and each line should be parsed into a Row object with two fields: an integer (epoch timestamp) and a string. The values on each line will be separated by a pipe (`|`), e.g., `1633024800|example_text`.

2. **Test the Reader with Partitioned Data:**
   - Create multiple directories (e.g., `dir1`, `dir2`, `dir3`), each containing a `.log` file named `partition.log` with a few lines of test data.
   - Write a simple Spark application that uses your custom reader to load data from the directories.

3. **Documentation:**
   - Provide a `README` file with instructions on how to compile and run your solution.
   - Include a short explanation (1-2 paragraphs) discussing your approach, how you handled directory-based partitioning, and any challenges you encountered.

### Requirements
- Implement the custom DataSource V2 reader using Spark’s DataSource V2 API.
- Your reader must:
  - **Support Directory-Based Partitioning:** Detect all directories containing `.log` files in a specified parent directory and create a separate partition for each directory.
  - **Handle Multiple Partitions:** Ensure that each directory is processed independently, allowing Spark to read and process multiple directories in parallel.
  - **Row Parsing:** Correctly parse each line into a Row object with an integer (epoch timestamp) and a string.

### Hints
- Review the [CSV DataSource V2 implementation](https://github.com/apache/spark/tree/v3.5.2/sql/core/src/main/scala/org/apache/spark/sql/execution/datasources/csv) in the Spark GitHub repository.

## Part 2: Performance Optimization with String Search

### Objective
Now that you have a working DataSource V2 reader, let’s consider how to optimize it for specific types of operations. Imagine that your data source can be optimized to handle string searches very efficiently, by leveraging Scala’s regular expressions for filtering lines before they are returned to Spark.

### Tasks

1. **Optimize the DataSource V2 Reader with String Search:**
   - **Enhanced Data Source Capabilities:** Suppose your data source is capable of performing highly efficient text searches directly within the files using Scala’s regular expressions. This allows you to perform `LIKE` operations or string filtering directly at the source level before the data is ingested by Spark.
   - **Implementation:** Explore how you might modify your DataSource V2 reader to take advantage of this capability, particularly for `LIKE` operations in Spark queries. Implement the ability to push down these string search operations to the data source, using Scala's built-in regular expressions to filter the data.

2. **Demonstrate the Optimization:**
   - Modify your existing Spark application to perform a `LIKE` operation on the string field. Ensure that the filtering happens at the data source level by leveraging the optimized string search capability.
   - The application should still demonstrate the directory-based partitioning, but now it should also showcase the efficiency gained by performing string searches before data is loaded into Spark.

3. **Documentation:**
   - Update your `README` file to include an explanation of how you approached this optimization, and what changes you made.

### Hints
- Think about how databases or search engines optimize string searches using tools like regular expressions. Consider how you might implement a similar approach within your DataSource V2 reader to handle `LIKE` operations more efficiently.
- Review Spark’s support for filter pushdown and how it can be used to implement this string search optimization in your custom data source.
- For inspiration, you may want to review the [`DataSourceV2Suite.scala` file](https://github.com/apache/spark/blob/v3.5.2/sql/core/src/test/scala/org/apache/spark/sql/connector/DataSourceV2Suite.scala#L763), which demonstrates predicate pushdown and other optimizations in the context of DataSource V2.

## Deliverables
- The complete source code for your custom DataSource V2 reader.
- A simple Spark SQL query against the hdx.takehome.logs table demonstrating the reader in action, reading from a parent directory containing multiple subdirectories, each with a `.log` file.
- A `README` file


# Getting Started

## 1. Fork this Repository

Click the ‘Fork’ button at the top right of this page to create your own copy of this repository.

## 2. Clone Your Fork

```
git clone https://github.com/hydrolix/hdx-spark-takehome.git
```


```
cd hdx-spark-takehome
```

## 3. Pull the Pre-built Docker Image

`docker pull fedrod/hdx-spark-takehome:latest`

## 4. Verify boilerplate is working

```
docker run -it --rm fedrod/hdx-spark-takehome:latest spark-shell
```

```
spark.sql("SELECT COUNT(*) FROM hdx.takehome.logs").show(false)
```

## 5. Implement Your Solution

Implement your custom DataSource V2 reader as per the assignment requirements.\
Add your Scala code files to the `src` directory in your local repository.

## 6. Run and Test Your Implementation

```
docker run -it --rm fedrod/hdx-spark-takehome:latest spark-shell
```

This will run an entrypoint into the Spark shell.

In the shell, you can test your implementation:

```
scala> spark.sql("SELECT * FROM hdx.takehome.logs").show(false)
```

To enter docker container in a bash shell, simply run
```
docker run -it --rm fedrod/hdx-spark-takehome:latest
```

## 7. Submit Your Solution

**Please make your repository private!**\
Push your changes to your fork, and invite the contributors of this repo (@fedrod @aggarwaa and @emanb29)

