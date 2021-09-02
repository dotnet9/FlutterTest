using System.Threading.Tasks;
using FlutterBilibiliAppWebAPI.Models;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace FlutterBilibiliAppWebAPI.Controllers
{
    [Route("api/[controller]")]
    public class TestController : Controller
    {
        // GET: api/values
        [HttpGet]
        public async Task<MessageModel<dynamic>> Get(string requestParams)
        {
            return await Task.Run(()=> MessageModel<dynamic>.Success(response: (code: 0, method: "GET", requestParams)));
        }
    }
}
