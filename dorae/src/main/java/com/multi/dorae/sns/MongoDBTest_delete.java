package com.multi.dorae.sns;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class MongoDBTest_delete {

	public static void main(String[] args) {
		// 1.몽고db 프로그램에 연결
		MongoClient client = new MongoClient("localhost", 27017);
		System.out.println("1. 몽고db프로그램에 연결 성공");
		// 2. shop2 db에 연결
		MongoDatabase database = client.getDatabase("shop2");
		System.out.println("2. shop2 db로 연결 성공.");
		// 3. member 컬렉션에 연결
		MongoCollection<Document> collection = database.getCollection("member");
		System.out.println("3. member 컬렉션에 연결 성공.");
		
		// 삭제할 조건을 json(Document)로 만들어주세요.
		Document filter = new Document();
		filter.append("id", "apple");
		
		collection.deleteOne(filter);
		client.close();
		System.out.println("4. member컬렉션에 deleteOne 성공.");
	}

}
