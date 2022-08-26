using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using WebBanNoiThat.Models;

namespace WebBanNoiThat.Controllers
{
    public class SanPhamController : Controller
    {
        private readonly BanNoiThatContext _dbContext;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private ISession _session => _httpContextAccessor.HttpContext.Session;

        public const string CART_KEY = "cart";

        public SanPhamController(BanNoiThatContext context, IHttpContextAccessor httpContextAccessor)
        {
            _dbContext = context;
            _httpContextAccessor = httpContextAccessor;
        }


        public ActionResult Index()
        {
            var hiepBaoComputerContext = _dbContext.SanPhams.Include(s => s.MaDmNavigation);
            var data = hiepBaoComputerContext.ToList();
            return View(data);
        }

        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sanPham =  _dbContext.SanPhams
                .Include(s => s.MaDmNavigation)
                .FirstOrDefault(m => m.MaSp == id);
            if (sanPham == null)
            {
                return NotFound();
            }

            return View(sanPham);
        }

        [HttpPost]
        public ActionResult Details(SanPham vm)
        {
            return RedirectToAction("AddToCart", "SanPham", new { @id = vm.MaSp, @soLuong = vm.SoLuong});
        }

        public ActionResult Cart()
        {
            var listItem = GetCartItems();
            return View(listItem);
        }
        public ActionResult AddToCart(int id, int soLuong = 1)
        {
            var sanPham = _dbContext.SanPhams.FirstOrDefault(p => p.MaSp == id);
            if (sanPham == null)
                return NotFound();

            var cartItem = new CartItem();
            cartItem.SoLuong = soLuong;
            cartItem.SanPham = sanPham;

            var listCartItems = GetCartItems();

            var itemInCart = listCartItems.FirstOrDefault(p => p.SanPham?.MaSp == id);
            if (itemInCart != null)
                itemInCart.SoLuong += soLuong;
            else
                listCartItems.Add(cartItem);
            SaveCartSession(listCartItems);

            return RedirectToAction("Cart", "SanPham");
        }

        [HttpPost]
        [Route("/updatecart", Name = "updatecart")]
        public JsonResult UpdateCartItem(int id, int soLuong = 1)
        {
            var listCartItems = GetCartItems();

            var itemInCart = listCartItems.FirstOrDefault(p => p.SanPham?.MaSp == id);
            if (itemInCart == null)
            {
                return Json(new { IsSuccess = false });
            }

            itemInCart.SoLuong += soLuong;
            SaveCartSession(listCartItems);

            return Json(new { IsSuccess = true });
        }

        public ActionResult RemoveCartItem(int id)
        {
            var listCartItems = GetCartItems();

            var itemInCart = listCartItems.FirstOrDefault(p => p.SanPham?.MaSp == id);
            if (itemInCart != null)
            {
                listCartItems.Remove(itemInCart);
                SaveCartSession(listCartItems);
            }

            return RedirectToAction("Cart", "SanPham");
        }

        public List<CartItem> GetCartItems()
        {
            string jsoncart = _session.GetString(CART_KEY);
            if (!string.IsNullOrWhiteSpace(jsoncart))
            {
                return JsonConvert.DeserializeObject<List<CartItem>>(jsoncart);
            }

            return new List<CartItem>();
        }

        void ClearCart()
        {
            _session.Remove(CART_KEY);
        }

        void SaveCartSession(List<CartItem> ls)
        {
            var session = HttpContext.Session;
            string jsoncart = JsonConvert.SerializeObject(ls);
            session.SetString(CART_KEY, jsoncart);
        }
    }
}
