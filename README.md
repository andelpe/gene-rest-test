# Gene REST API example
Flask and MySQL-based REST application to access gene information


## Description
The code in this repository implements a REST service providing gene-related information.
The REST service is implemented as a Flask application, which accesses a MySQL database
containing the gene information.

The REST interface implements an endpoint `symbol`, which accepts an input gene symbol and
returns JSON string with the following information:

- Gene symbol
- Gene stable ID
- A list of genes matching the specified gene symbol
- A list of stable IDs of all the transcripts associated with the gene

However, since there are several possible ways to structure the returned information, two
alternative methods have been really implemented. The `symbol` endpoint returns a nested
structure with less redundant data, while the alternative `symbol_flat` endpoint returns a
flat list of data, where some data are repeated.


## Requirements
The application requires Python, Flask and MySQL.

For a Debian-based Linux system, these could be installed with:
```
sudo apt update
sudo apt-get install \
   python3-pip \
   python3-flask \
   mysql-server

pip install flask mysql-connector-python
```


## Deployment
If not running, start the MySQL service:
```
sudo service mysql start
```

Let us now create a MySQL user and database for our test. Run:
```
sudo mysql
```

And at the MySQL prompt:
```
CREATE DATABASE genes;

CREATE USER 'test'@'localhost' IDENTIFIED WITH 'testpass';
GRANT ALL PRIVILEGES ON genes.* TO 'test'@'localhost';
```

Now, in your work area, clone this repository and cd into it:
```
git clone https://github.com/andelpe/gene-rest-test.git
cd gene-rest-test
```

Finally, populate de database:
```
mysql -u test -p    # use 'testpass' as password
```

And at the MySQL prompt:
```
use genes
source ./test-data.sql
```


## Execution
To prepare the environment and run the Flask application, just do:
```
export FLASK_APP=genes_rest.py
export FLASK_ENV=development
flask run
```

## Usage
Once the REST application is running, you can query it using your browser or a utility
like `curl`. You should point them to `http://127.0.0.1:5000/symbol/<symbol>`, where
`<symbol>` is the gene symbol you want to match, for the nested structure. Alternatively,
use `http://127.0.0.1:5000/symbol_flat/<symbol>` for the flat list.

E.g.:
```
$> curl http://127.0.0.1:5000/symbol/JAG1
{
  "genes": {
    "1": {
      "gene_id": 1,
      "gene_stable_id": "ENSG00000101384.12",
      "transcript_stable_ids": [
        "ENST00000254958.10"
      ]
    },
    "2": {
      "gene_id": 2,
      "gene_stable_id": "ENSG00000101384.11",
      "transcript_stable_ids": [
        "ENST00000254958.9"
      ]
    },
    "3": {
      "gene_id": 3,
      "gene_stable_id": "ENSG00000101384.7",
      "transcript_stable_ids": [
        "ENST00000254958.5",
        "ENST00000423891.2"
      ]
    },
    "4": {
      "gene_id": 4,
      "gene_stable_id": "ENSMUSG00000027276.8",
      "transcript_stable_ids": [
        "ENSMUST00000028735.8"
      ]
    }
  },
  "symbol": "JAG1"
}
```

Or:
```
$> curl http://127.0.0.1:5000/symbol_flat/JAG1
[
  {
    "gene_id": 1,
    "gene_stable_id": "ENSG00000101384.12",
    "symbol": "JAG1",
    "transcript_stable_id": "ENST00000254958.10"
  },
  {
    "gene_id": 2,
    "gene_stable_id": "ENSG00000101384.11",
    "symbol": "JAG1",
    "transcript_stable_id": "ENST00000254958.9"
  },
  {
    "gene_id": 3,
    "gene_stable_id": "ENSG00000101384.7",
    "symbol": "JAG1",
    "transcript_stable_id": "ENST00000254958.5"
  },
  {
    "gene_id": 3,
    "gene_stable_id": "ENSG00000101384.7",
    "symbol": "JAG1",
    "transcript_stable_id": "ENST00000423891.2"
  },
  {
    "gene_id": 4,
    "gene_stable_id": "ENSMUSG00000027276.8",
    "symbol": "JAG1",
    "transcript_stable_id": "ENSMUST00000028735.8"
  }
]
```

