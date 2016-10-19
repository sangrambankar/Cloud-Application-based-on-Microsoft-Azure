package com.cloud.assign10;

import java.util.List;

import com.microsoft.azure.documentdb.ConnectionPolicy;
import com.microsoft.azure.documentdb.ConsistencyLevel;
import com.microsoft.azure.documentdb.Database;
import com.microsoft.azure.documentdb.DocumentClient;
import com.microsoft.azure.documentdb.DocumentClientException;
import com.microsoft.azure.documentdb.DocumentCollection;
import com.microsoft.azure.documentdb.RequestOptions;



public class TableStore {
	
	private static final String HOST = "/";
	private static final String MASTER_KEY = "==";
    private static final String DATABASE_ID = "MyDB";

	public static DocumentClient getDocumentClient() {
		DocumentClient documentClient = null;
	    if (documentClient == null) {
	        documentClient = new DocumentClient(HOST, MASTER_KEY,
	                ConnectionPolicy.GetDefault(), ConsistencyLevel.Session);
	    }

	    return documentClient;
	}

	
	public void createDatabase() throws Exception{
		 // Define a new database using the id above.
        Database myDatabase = new Database();
        myDatabase.setId(DATABASE_ID);
        // Create a new database.
        myDatabase = TableStore.getDocumentClient().createDatabase(myDatabase, null)
                .getResource();
	}
	
	
}
