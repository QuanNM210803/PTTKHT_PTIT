package config;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Thanhvien;

import java.io.IOException;

public class AuthFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        HttpSession session = req.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("user") != null);
        
        String loginURI = req.getContextPath() + "/GDDangnhap.jsp"; // pttkht/GDDangnhap.jsp
        
        if (loggedIn) {
        	Thanhvien thanhvien=(Thanhvien)session.getAttribute("user");
        	String vaitro=thanhvien.getVaitro();
        	
        	if (vaitro == null) {
                res.sendRedirect(loginURI);
                return;
            }

        	String requestURI = req.getRequestURI();
            if (requestURI.startsWith(req.getContextPath() + "/quanly") && !vaitro.equals("QL")) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            } else if (requestURI.startsWith(req.getContextPath() + "/nhanvienbanve") && !vaitro.equals("NVBV")) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(loginURI);
        }
    }

    @Override
    public void destroy() {
    }
}

