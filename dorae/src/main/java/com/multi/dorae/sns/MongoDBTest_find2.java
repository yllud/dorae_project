package com.multi.dorae.sns;

import java.util.ArrayList;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class MongoDBTest_find2 {

	public static void main(String[] args) {
		// 1.몽고db 프로그램에 연결
		MongoClient client = new MongoClient("localhost", 27017);
		System.out.println("1. 몽고db프로그램에 연결 성공");
		// 2. shop2 db에 연결
		MongoDatabase database = client.getDatabase("shop2");
		System.out.println("2. shop2 db로 연결 성공.");
		// 3. memo 컬렉션에 연결
		MongoCollection<Document> collection = database.getCollection("memo");
		System.out.println("3. memo 컬렉션에 연결 성공.");
		
		FindIterable<Document> list = collection.find();
		ArrayList<MemoVO> result = new ArrayList<MemoVO>();
		for (Document document : list) {
//			System.out.println(document);
			MemoVO bag = new MemoVO();
			bag.setAge(document.getInteger("age"));
			bag.setName(document.getString("name"));
			bag.setOffice(document.getString("office"));
			bag.setPhone(document.getString("phone"));
			result.add(bag);
		}
		System.out.println(result);
		client.close();
	}

}
