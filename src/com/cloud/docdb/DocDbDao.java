package com.cloud.docdb;

import java.util.ArrayList;
import java.util.List;

import com.cloud.assign10.UserTable;
import com.google.gson.Gson;
import com.microsoft.azure.documentdb.Database;
import com.microsoft.azure.documentdb.Document;
import com.microsoft.azure.documentdb.DocumentClient;
import com.microsoft.azure.documentdb.DocumentClientException;
import com.microsoft.azure.documentdb.DocumentCollection;

public class DocDbDao {

	
	 // The name of our database.
    private static final String DATABASE_ID = "MyDB";

    // The name of our collection.
    private static final String COLLECTION_ID = "user";

    // We'll use Gson for POJO <=> JSON serialization for this example.
    private static Gson gson = new Gson();

    // The DocumentDB Client
    private static DocumentClient documentClient = DocumentClientFactory.getDocumentClient();

    // Cache for the database object, so we don't have to query for it to
    // retrieve self links.
    private static Database databaseCache;

    // Cache for the collection object, so we don't have to query for it to
    // retrieve self links.
    private static DocumentCollection collectionCache;

    public UserTable createUserItem(UserTable todoItem) throws Exception {
        // Serialize the TodoItem as a JSON Document.
        Document todoItemDocument = new Document(gson.toJson(todoItem));

        // Annotate the document as a TodoItem for retrieval (so that we can
        // store multiple entity types in the collection).
            // Persist the document using the DocumentClient.
            todoItemDocument = documentClient.createDocument(
            		getUserCollection().getSelfLink(), todoItemDocument, null,
                    false).getResource();

        return gson.fromJson(todoItemDocument.toString(), UserTable.class);
    }

    public UserTable readUserItem(String uname) {
        // Retrieve the document by id using our helper method.
        Document todoItemDocument = getDocumentByUname(uname);

        if (todoItemDocument != null) {
            // De-serialize the document in to a TodoItem.
            return gson.fromJson(todoItemDocument.toString(), UserTable.class);
        } else {
            return null;
        }
    }

    public List<UserTable> readTodoItems() {
        List<UserTable> todoItems = new ArrayList<UserTable>();

        // Retrieve the TodoItem documents
        List<Document> documentList = documentClient
                .queryDocuments(getUserCollection().getSelfLink(),
                        "SELECT * FROM root r WHERE r.entityType = 'todoItem'",
                        null).getQueryIterable().toList();

        // De-serialize the documents in to TodoItems.
        for (Document todoItemDocument : documentList) {
            todoItems.add(gson.fromJson(todoItemDocument.toString(),
            		UserTable.class));
        }

        return todoItems;
    }

    public UserTable updateTodoItem(String uname,String type) throws Exception{
        // Retrieve the document from the database
        Document todoItemDocument = getDocumentByUname(uname);

        // You can update the document as a JSON document directly.
        // For more complex operations - you could de-serialize the document in
        // to a POJO, update the POJO, and then re-serialize the POJO back in to
        // a document.
        if(type.equalsIgnoreCase("Picture")){
        	int photoused = Integer.parseInt(todoItemDocument.getString("photoused"));
        	photoused++;
            todoItemDocument.set("photoused", photoused+"");
		}else{
			int noteused = Integer.parseInt(todoItemDocument.getString("noteused"));
			noteused++;
            todoItemDocument.set("noteused", noteused+"");
		}
            // Persist/replace the updated document.
            todoItemDocument = documentClient.replaceDocument(todoItemDocument,
                    null).getResource();

        return gson.fromJson(todoItemDocument.toString(), UserTable.class);
    }

    
    
    public UserTable updateDeleteTodoItem(String uname,String type) throws Exception{
        // Retrieve the document from the database
        Document todoItemDocument = getDocumentByUname(uname);

        // You can update the document as a JSON document directly.
        // For more complex operations - you could de-serialize the document in
        // to a POJO, update the POJO, and then re-serialize the POJO back in to
        // a document.
        if(type.equalsIgnoreCase("Picture")){
        	int photoused = Integer.parseInt(todoItemDocument.getString("photoused"));
        	photoused--;
            todoItemDocument.set("photoused", photoused+"");
		}else{
			int noteused = Integer.parseInt(todoItemDocument.getString("noteused"));
			noteused--;
            todoItemDocument.set("noteused", noteused+"");
		}
            // Persist/replace the updated document.
            todoItemDocument = documentClient.replaceDocument(todoItemDocument,
                    null).getResource();

        return gson.fromJson(todoItemDocument.toString(), UserTable.class);
    }

    public boolean deleteTodoItem(String id) {
        // DocumentDB refers to documents by self link rather than id.

        // Query for the document to retrieve the self link.
        Document todoItemDocument = getDocumentByUname(id);

        try {
            // Delete the document by self link.
            documentClient.deleteDocument(todoItemDocument.getSelfLink(), null);
        } catch (DocumentClientException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    private Database getUserDatabase() {
        if (databaseCache == null) {
            // Get the database if it exists
            List<Database> databaseList = documentClient
                    .queryDatabases(
                            "SELECT * FROM root r WHERE r.id='" + DATABASE_ID
                                    + "'", null).getQueryIterable().toList();

            if (databaseList.size() > 0) {
                // Cache the database object so we won't have to query for it
                // later to retrieve the selfLink.
                databaseCache = databaseList.get(0);
            } else {
                // Create the database if it doesn't exist.
                try {
                    Database databaseDefinition = new Database();
                    databaseDefinition.setId(DATABASE_ID);

                    databaseCache = documentClient.createDatabase(
                            databaseDefinition, null).getResource();
                } catch (DocumentClientException e) {
                    // TODO: Something has gone terribly wrong - the app wasn't
                    // able to query or create the collection.
                    // Verify your connection, endpoint, and key.
                    e.printStackTrace();
                }
            }
        }

        return databaseCache;
    }

    private DocumentCollection getUserCollection() {
        if (collectionCache == null) {
            // Get the collection if it exists.
            List<DocumentCollection> collectionList = documentClient
                    .queryCollections(
                    		getUserDatabase().getSelfLink(),
                            "SELECT * FROM root r WHERE r.id='" + COLLECTION_ID
                                    + "'", null).getQueryIterable().toList();

            if (collectionList.size() > 0) {
                // Cache the collection object so we won't have to query for it
                // later to retrieve the selfLink.
                collectionCache = collectionList.get(0);
            } else {
                // Create the collection if it doesn't exist.
                try {
                    DocumentCollection collectionDefinition = new DocumentCollection();
                    collectionDefinition.setId(COLLECTION_ID);

                    collectionCache = documentClient.createCollection(
                    		getUserDatabase().getSelfLink(),
                            collectionDefinition, null).getResource();
                } catch (DocumentClientException e) {
                    // TODO: Something has gone terribly wrong - the app wasn't
                    // able to query or create the collection.
                    // Verify your connection, endpoint, and key.
                    e.printStackTrace();
                }
            }
        }

        return collectionCache;
    }

    private Document getDocumentByUname(String username) {
        // Retrieve the document using the DocumentClient.
        List<Document> documentList = documentClient
                .queryDocuments(getUserCollection().getSelfLink(),
                        "SELECT * FROM user r WHERE r.uname='" + username + "'", null)
                .getQueryIterable().toList();

        if (documentList.size() > 0) {
            return documentList.get(0);
        } else {
            return null;
        }
    }

}
