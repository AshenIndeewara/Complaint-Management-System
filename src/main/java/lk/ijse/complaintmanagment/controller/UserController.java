package lk.ijse.complaintmanagment.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.complaintmanagment.dao.UserDAO;
import lk.ijse.complaintmanagment.model.User;
import lk.ijse.complaintmanagment.util.UserIDQrEncryption;

import java.io.IOException;
import java.util.List;

@WebServlet("/manageusers")
public class UserController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String allUsersSQL = "SELECT * FROM users";
        List<User> users = UserDAO.getAllUsers(getServletContext(), allUsersSQL);
        req.setAttribute("userList", users);
        String action = req.getParameter("action");
        if(action!=null) {
            System.out.println("Action: " + action);
            if (action.equals("makeadmin")) {
                String userId = req.getParameter("userid");
                String updateSQL = "UPDATE users SET role = 'ADMIN' WHERE id = ?";
                int status = UserDAO.updateUserRole(getServletContext(), updateSQL, userId);
                if (status > 0) {
                    req.setAttribute("message", "User with ID " + userId + " has been made an admin.");
                } else {
                    req.setAttribute("errorMessage", "Failed to make user an admin.");
                }
            } else if (action.equals("delete")) {
                String userId = req.getParameter("userid");
                String deleteSQL = "DELETE FROM users WHERE id = ?";
                int status = UserDAO.deleteUser(getServletContext(), deleteSQL, userId);
                if (status > 0) {
                    req.setAttribute("message", "User with ID " + userId + " has been deleted.");
                } else {
                    req.setAttribute("errorMessage", "Failed to delete user.");
                }
            }
        }
        req.getRequestDispatcher("/admin/Userdashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String userId = req.getParameter("userid");
        String username = req.getParameter("username");
        String role = req.getParameter("role");
        String password = req.getParameter("password");
        String sql;
        Boolean isUpdated;
        if(password!=null && !password.isEmpty()) {
            sql = "UPDATE users SET username = ?, password = ?, role = ? WHERE id = ?";
            try {
                password = UserIDQrEncryption.encrypt(password);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            isUpdated = UserDAO.update(getServletContext(), sql, username, password, role, userId);
        } else {
            sql = "UPDATE users SET username = ?, role = ? WHERE id = ?";
            isUpdated = UserDAO.update(getServletContext(), sql, username, role, userId);
        }
        if (isUpdated) {
            req.setAttribute("message", "User with ID " + userId + " has been updated successfully.");
        } else {
            req.setAttribute("errorMessage", "Failed to update user with ID " + userId + ".");
        }
        String allUsersSQL = "SELECT * FROM users";
        List<User> users = UserDAO.getAllUsers(getServletContext(), allUsersSQL);
        req.setAttribute("userList", users);
        req.getRequestDispatcher("/admin/Userdashboard.jsp").forward(req, resp);
    }
}
