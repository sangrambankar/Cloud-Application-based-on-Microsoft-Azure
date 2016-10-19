package com.cloud.docdb;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import org.apache.http.HttpRequest;

import com.microsoft.azure.documentdb.ConnectionPolicy;
import com.microsoft.azure.documentdb.ConsistencyLevel;
import com.microsoft.azure.documentdb.DocumentClient;
//Include the following imports to use blob APIs.
import com.microsoft.azure.storage.CloudStorageAccount;
import com.microsoft.azure.storage.StorageException;
import com.microsoft.azure.storage.blob.BlobContainerPermissions;
import com.microsoft.azure.storage.blob.BlobContainerPublicAccessType;
import com.microsoft.azure.storage.blob.CloudBlobClient;
import com.microsoft.azure.storage.blob.CloudBlobContainer;
import com.microsoft.azure.storage.blob.CloudBlockBlob;

public class DocumentClientFactory {

	
	private static final String HOST = "";
	private static final String MASTER_KEY = "==";

	// Define the connection-string with your values
	public static final String storageConnectionString =
	    "DefaultEndpointsProtocol=http;" +
	    "AccountName=appcloud6331;" +
	    "AccountKey='put your key here'";
	
    private static DocumentClient documentClient;

    public static DocumentClient getDocumentClient() {
        if (documentClient == null) {
            documentClient = new DocumentClient(HOST, MASTER_KEY,
                    ConnectionPolicy.GetDefault(), ConsistencyLevel.Session);
        }

        return documentClient;
    }
    
    
    public static CloudBlobContainer getCloudContainer() throws Exception{
    	// Retrieve storage account from connection-string.
    	CloudStorageAccount storageAccount = CloudStorageAccount.parse(storageConnectionString);
        // Create the blob client.
       CloudBlobClient blobClient = storageAccount.createCloudBlobClient();
       // Get a reference to a container.
       // The container name must be lower case
       CloudBlobContainer container = blobClient.getContainerReference("cloud6331finalassign");
       // Create the container if it does not exist.
        container.createIfNotExists();
        // Create a permissions object.
        BlobContainerPermissions containerPermissions = new BlobContainerPermissions();
        // Include public access in the permissions object.
        containerPermissions.setPublicAccess(BlobContainerPublicAccessType.CONTAINER);
        // Set the permissions on the container.
        container.uploadPermissions(containerPermissions);
    	
    	
		return container;
    	
    }

    public static String getUploadUrl(File source,String fname) throws Exception{
    	// Define the path to a local file.
        // Create or overwrite the "myimage.jpg" blob with contents from a local file.
    	String filename;
    	if(fname!=null){
    		filename = fname;
    	}else{
    		filename = source.getName();
    	}
        CloudBlockBlob blob = getCloudContainer().getBlockBlobReference(filename);
        blob.upload(new FileInputStream(source), source.length());    	
        URI url = blob.getUri();
        
		return url.toURL()+"";
    }

    public static String getDownloadFile(HttpServletRequest req,String fname) throws Exception {
    	   CloudBlockBlob blob = getCloudContainer().getBlockBlobReference(fname);
    	   String path = req.getContextPath()+"output.txt";
           blob.download(new FileOutputStream(path));
    	
		return path;
	}
    
}
