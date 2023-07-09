package com.java501.S20230401;

import javax.sql.DataSource;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@EnableTransactionManagement
@SpringBootApplication
public class S20230401Application {

	// Configuration과 TransactionManager를 java에서 Bean설정 Oracle
    @Bean
    @ConfigurationProperties(prefix = "spring.oracle.datasource")
    public DataSource dataSource() {
        DataSourceBuilder<?> dataSource = DataSourceBuilder.create();
        dataSource.url("jdbc:oracle:thin:@localhost:1521/xe");
        dataSource.username("S20230401");
	    dataSource.password("tiger");
        return dataSource.build();
    }
    @Bean
    public DataSourceTransactionManager transactionManager() {
    	DataSourceTransactionManager manager = new DataSourceTransactionManager();
    	manager.setDataSource(dataSource());
    	return manager;
    }
	
	public static void main(String[] args) {
		SpringApplication.run(S20230401Application.class, args);
	}

}
