package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import beans.User;

@WebFilter(urlPatterns = {"/*"})
public class IsWorkingFilter implements Filter {
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpSession session = ((HttpServletRequest)request).getSession();
		User user = (User) session.getAttribute("loginUser");

//		if (user.getIs_working() !=1 && !((HttpServletRequest) request).getServletPath().equals("/login")) {
//
//			((HttpServletResponse) response).sendRedirect("login");
//			return;
//		}
//		if (user != null){
//			HttpSession nextsession = ((HttpServletRequest)request).getSession();
//			User nextuser = (User) nextsession.getAttribute("loginUser");
//		}

		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig config) {

	}

	@Override
	public void destroy() {
	}

}
