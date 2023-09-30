from flask import Flask, request, jsonify
import mysql.connector

# Create connection to the DB (potentially usable by several methods)
dbconf = {
    'host':'localhost',
    'database': 'genes',
    'user': 'test',
    'password': 'testpass'
}
conn = mysql.connector.connect(**dbconf)

# Flask app
app = Flask(__name__)

# Method for 'symbol' endpoint (GET)
@app.route("/symbol/<symbol>", methods=["GET"])
def match_symbol(symbol):

    cursor = None

    query = f"""
SELECT gene.gene_id, gene.stable_id as gsid, transcript.stable_id  as tsid
    FROM gene INNER JOIN transcript ON gene.gene_id=transcript.gene_id 
    WHERE gene.symbol="{symbol}"
"""
    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute(query)

        rows = cursor.fetchall()
        if rows is None:  return {"error": "Unknown symbol"}, 404
 
        # Process result to avoid redundancy
        result = {
            'symbol': symbol,
            'genes': {},
        }
        for row in rows:
            gene_id = row['gene_id']
            if gene_id in result['genes']:
                result['genes'][gene_id]['transcript_stable_ids'].append(row['tsid'])
            else:
                result['genes'][gene_id] = {
                    'gene_stable_id': row['gsid'],
                    'gene_id': gene_id,
                    'transcript_stable_ids': [row['tsid']],
                }

        # Return json
        return jsonify(result)
 
    except Exception as err:
        return {"error": str(err)}, 500
 
    finally:
        if cursor:  cursor.close()


# Alternative method for 'symbol' with "flat" response 
@app.route("/symbol_flat/<symbol>", methods=["GET"])
def match_symbol_flat(symbol):

    cursor = None

    query = f"""
SELECT gene.gene_id, gene.symbol, gene.stable_id as gene_stable_id, transcript.stable_id  as transcript_stable_id
    FROM gene INNER JOIN transcript ON gene.gene_id=transcript.gene_id 
    WHERE gene.symbol="{symbol}"
"""
    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute(query)

        rows = cursor.fetchall()
        if rows is None:  return {"error": "Unknown symbol"}, 404

        # Return json
        return jsonify(rows)
 
    except Exception as err:
        return {"error": str(err)}, 500
 
    finally:
        if cursor:  cursor.close()
