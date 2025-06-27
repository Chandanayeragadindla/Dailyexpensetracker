package org.example.dailyexpensetrackerproject;

import java.sql.*;
import java.util.HashMap;

public class UserDAO {


    public boolean insertUser(User user) {
        boolean isInserted = false;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO users (email, password) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                isInserted = true;
            }

        } catch (SQLIntegrityConstraintViolationException e) {
            System.out.println("User already exists: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Error inserting user: " + e.getMessage());
            e.printStackTrace();
        }

        return isInserted;
    }

    public boolean validateUser(String email, String password) {
        boolean isValid = false;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                isValid = true;
            }

        } catch (Exception e) {
            System.err.println("Error validating user: " + e.getMessage());
            e.printStackTrace();
        }

        return isValid;
    }

    public int getUserId(String userEmail) {
        int userId = -1;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id FROM users WHERE email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userEmail);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                userId = rs.getInt("id");
            }

        } catch (Exception e) {
            System.err.println("Error getting user ID: " + e.getMessage());
            e.printStackTrace();
        }

        return userId;
    }

    //view expenses
    public HashMap<String, HashMap<Date, HashMap<String, int[]>>> getExpenses(String userEmail) {
        String query = "SELECT * FROM expenses WHERE user_email = ?";
        HashMap<String, HashMap<Date, HashMap<String, int[]>>> expenses = new HashMap<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, userEmail);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String category = rs.getString("category");
                String subCategory = rs.getString("subcategory");
                String date = rs.getString("date");
                java.sql.Date sqlDate = java.sql.Date.valueOf(date);
                String description = rs.getString("description");
                int amount = (int) rs.getDouble("price");

                // 3-Level Nested HashMap Processing
                if (expenses.containsKey(category)) {
                    HashMap<Date, HashMap<String, int[]>> categoryData = expenses.get(category);

                    if (categoryData.containsKey(sqlDate)) {
                        HashMap<String, int[]> dateData = categoryData.get(sqlDate);

                        if (dateData.containsKey(subCategory)) {
                            int[] existingData = dateData.get(subCategory);
                            existingData[0] += 1;
                            existingData[1] += amount;
                            dateData.put(subCategory, existingData);
                        } else {
                            int[] newSubCategoryData = new int[2];
                            newSubCategoryData[0] = 1;
                            newSubCategoryData[1] = amount;
                            dateData.put(subCategory, newSubCategoryData);
                        }
                        categoryData.put(sqlDate, dateData);
                        expenses.put(category, categoryData);
                    } else {
                        HashMap<String, int[]> newDateData = new HashMap<>();
                        int[] newSubCategoryData = new int[2];
                        newSubCategoryData[0] = 1;
                        newSubCategoryData[1] = amount;
                        newDateData.put(subCategory, newSubCategoryData);
                        categoryData.put(sqlDate, newDateData);
                        expenses.put(category, categoryData);
                    }
                } else {
                    HashMap<String, int[]> newSubCategoryMap = new HashMap<>();
                    int[] newSubCategoryData = new int[2];
                    newSubCategoryData[0] = 1;
                    newSubCategoryData[1] = amount;
                    newSubCategoryMap.put(subCategory, newSubCategoryData);

                    HashMap<Date, HashMap<String, int[]>> newDateMap = new HashMap<>();
                    newDateMap.put(sqlDate, newSubCategoryMap);

                    expenses.put(category, newDateMap);
                }
            }
        } catch (SQLException   | ClassNotFoundException e) {
            System.out.println( "error " + e.getMessage());
        }
        return expenses;
    }


    public HashMap<String, HashMap<Date, HashMap<String, int[]>>> filteredExpenses(
            int userId, String category, String startDate, String endDate) {
        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM expenses WHERE user_email = (SELECT email FROM users WHERE id = ?)");


        if (category != null && !category.isEmpty()) {
            queryBuilder.append(" AND category = ?");
        }


        if (startDate != null && !startDate.isEmpty()) {
            queryBuilder.append(" AND date >= ?");
        }

        if (endDate != null && !endDate.isEmpty()) {
            queryBuilder.append(" AND date <= ?");
        }

        String query = queryBuilder.toString();
        HashMap<String, HashMap<Date, HashMap<String, int[]>>> expenses = new HashMap<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {


            int parameterIndex = 1;

            stmt.setInt(parameterIndex++, userId);

            if (category != null && !category.isEmpty()) {
                stmt.setString(parameterIndex++, category);
            }

            if (startDate != null && !startDate.isEmpty()) {
                stmt.setString(parameterIndex++, startDate);
            }

            if (endDate != null && !endDate.isEmpty()) {
                stmt.setString(parameterIndex++, endDate);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String resultCategory = rs.getString("category");
                String subCategory = rs.getString("subcategory");
                String date = rs.getString("date");
                java.sql.Date sqlDate = java.sql.Date.valueOf(date);
                int amount = (int) rs.getDouble("price");

                if (expenses.containsKey(resultCategory)) {
                    HashMap<Date, HashMap<String, int[]>> categoryData = expenses.get(resultCategory);

                    if (categoryData.containsKey(sqlDate)) {
                        HashMap<String, int[]> dateData = categoryData.get(sqlDate);

                        if (dateData.containsKey(subCategory)) {
                            int[] existingData = dateData.get(subCategory);
                            existingData[0] += 1;
                            existingData[1] += amount;
                            dateData.put(subCategory, existingData);
                        } else {
                            int[] newSubCategoryData = new int[2];
                            newSubCategoryData[0] = 1;
                            newSubCategoryData[1] = amount;
                            dateData.put(subCategory, newSubCategoryData);
                        }
                        categoryData.put(sqlDate, dateData);
                        expenses.put(resultCategory, categoryData);
                    } else {
                        HashMap<String, int[]> newDateData = new HashMap<>();
                        int[] newSubCategoryData = new int[2];
                        newSubCategoryData[0] = 1;
                        newSubCategoryData[1] = amount;
                        newDateData.put(subCategory, newSubCategoryData);
                        categoryData.put(sqlDate, newDateData);
                        expenses.put(resultCategory, categoryData);
                    }
                } else {
                    HashMap<String, int[]> newSubCategoryMap = new HashMap<>();
                    int[] newSubCategoryData = new int[2];
                    newSubCategoryData[0] = 1;
                    newSubCategoryData[1] = amount;
                    newSubCategoryMap.put(subCategory, newSubCategoryData);

                    HashMap<Date, HashMap<String, int[]>> newDateMap = new HashMap<>();
                    newDateMap.put(sqlDate, newSubCategoryMap);

                    expenses.put(resultCategory, newDateMap);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error fetching filtered expenses: " + e.getMessage());
            e.printStackTrace();
        }
        return expenses;
    }
}