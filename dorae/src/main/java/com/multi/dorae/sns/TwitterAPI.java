package com.multi.dorae.sns;

import java.util.ArrayList;
import java.util.List;

import twitter4j.*;
import twitter4j.conf.ConfigurationBuilder;

public class TwitterAPI {
    public static List<TwitterVO> searchTweets(String keyword) throws TwitterException {
        // Twitter API 인증 정보
        String consumerKey = "2bC5GdvhJiWAqzZs2vq99msHh";
        String consumerSecret = "iqJdooedkoVi1VckFFtu6VvEMXYM3i0HaC3E1jcGoQYhAgqv7S";
        String accessToken = "1651470021489721344-RcvL8t0JHmsGzskjJ0CFrd2MNXsrfa";
        String accessTokenSecret = "R8Ix7nZwfzdys7IEZgOPdIznV4BcZEkNuEZIJgk081fWJ";

        // Twitter 객체 생성
        ConfigurationBuilder cb = new ConfigurationBuilder();
        cb.setDebugEnabled(true)
            .setOAuthConsumerKey(consumerKey)
            .setOAuthConsumerSecret(consumerSecret)
            .setOAuthAccessToken(accessToken)
            .setOAuthAccessTokenSecret(accessTokenSecret);

        TwitterFactory tf = new TwitterFactory(cb.build());
        Twitter twitter = tf.getInstance();

        // 검색 수행
        Query query = new Query(keyword);
        QueryResult result = twitter.search(query);

        // 결과 리스트 생성
        List<TwitterVO> tweets = new ArrayList<>();

        // 결과 객체 생성
        for (Status status : result.getTweets()) {
            TwitterVO tweet = new TwitterVO();
            tweet.setUser(status.getUser().getName());
            tweet.setScreenName(status.getUser().getScreenName());
            tweet.setText(status.getText());
            tweets.add(tweet);
        }

        return tweets;
    }
}
