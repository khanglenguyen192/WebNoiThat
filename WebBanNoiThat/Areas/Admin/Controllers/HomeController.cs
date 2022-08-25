using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace WebBanNoiThat.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class HomeController : Controller
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private ISession _session => _httpContextAccessor.HttpContext.Session;

        public HomeController(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public ActionResult Index()
        {
            if (_session.Get("taikhoan") == null)
                return RedirectToAction("Login", "Account");
            return View();
        }
    }
}
