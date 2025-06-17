package lk.ijse.complaintmanagment.dao;

import jakarta.servlet.ServletContext;
import lk.ijse.complaintmanagment.model.User;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UserDAO {


    public static User findUserByUsername(ServletContext context, String sql, Object... obj) throws SQLException {
        BasicDataSource dataSource = (BasicDataSource) context.getAttribute("ds");
        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        for (int i = 0; i < obj.length; i++) {
            preparedStatement.setObject(i + 1, obj[i]);
        }
        ResultSet resultSet = preparedStatement.executeQuery();
        User user = null;
        if (resultSet.next()) {
            System.out.println("User found: " + resultSet.getString("username"));
            user = new User(
                    resultSet.getInt("id"),
                    resultSet.getString("username"),
                    resultSet.getString("password"),
                    resultSet.getString("role")
            );

        }
        connection.close();
        return user;
    }

    public static Boolean addUser(ServletContext context, String sql, Object... obj) throws SQLException {
        BasicDataSource dataSource = (BasicDataSource) context.getAttribute("ds");
        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        for (int i = 0; i < obj.length; i++) {
            preparedStatement.setObject(i + 1, obj[i]);
        }
        int rowsAffected = preparedStatement.executeUpdate();
        connection.close();
        return rowsAffected > 0;
    }

    public static List<User> getAllUsers(ServletContext servletContext, String allUsersSQL) {
        BasicDataSource dataSource = (BasicDataSource) servletContext.getAttribute("ds");
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(allUsersSQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            List<User> userList = new java.util.ArrayList<>();
            while (resultSet.next()) {
                User user = new User(
                        resultSet.getInt("id"),
                        resultSet.getString("username"),
                        resultSet.getString("password"),
                        resultSet.getString("role")
                );
                userList.add(user);
            }
            return userList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static int updateUserRole(ServletContext servletContext, String updateSQL, String userId) {
        BasicDataSource dataSource = (BasicDataSource) servletContext.getAttribute("ds");
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(updateSQL)) {
            preparedStatement.setString(1, userId);
            System.out.println(preparedStatement.toString());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static int deleteUser(ServletContext servletContext, String deleteSQL, String userId) {
        BasicDataSource dataSource = (BasicDataSource) servletContext.getAttribute("ds");
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(deleteSQL)) {
            preparedStatement.setString(1, userId);
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static Boolean update(ServletContext servletContext, String sql, Object... obj) {
        BasicDataSource dataSource = (BasicDataSource) servletContext.getAttribute("ds");
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            for (int i = 0; i < obj.length; i++) {
                preparedStatement.setObject(i + 1, obj[i]);
            }
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
