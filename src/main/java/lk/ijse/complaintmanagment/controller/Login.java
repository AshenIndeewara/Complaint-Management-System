package lk.ijse.complaintmanagment.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.ijse.complaintmanagment.dao.UserDAO;
import lk.ijse.complaintmanagment.model.User;
import lk.ijse.complaintmanagment.util.JWTUtil;
import lk.ijse.complaintmanagment.util.UserIDQrEncryption;

import java.io.IOException;

@WebServlet("/login")
public class Login extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        System.out.println("Username: " + username);
        System.out.println("Password: " + password);
        if (username == null || username.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
        try {
            String sql = "SELECT * FROM users WHERE username = ?";
            User user = UserDAO.findUserByUsername(getServletContext(), sql, username);
            user.show();
            if (user == null) {
                req.setAttribute("errorMessage", "Invalid username or password.");
                resp.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }
            if(UserIDQrEncryption.decrypt(password, user.getPassword())){
                HttpSession session = req.getSession();
                session.setAttribute("user", user.getId());
                session.setAttribute("role", user.getRole());
                if ("ADMIN".equals(user.getRole())) {
                    resp.sendRedirect(req.getContextPath() + "/dashboard");
                } else if ("EMPLOYEE".equals(user.getRole())) {
                    resp.sendRedirect(req.getContextPath() + "/dashboard");
                } else {
                    resp.getWriter().println("Invalid role.");
                }
                return;
            } else {
                resp.sendRedirect(req.getContextPath() + "/login.jsp");
            }
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
