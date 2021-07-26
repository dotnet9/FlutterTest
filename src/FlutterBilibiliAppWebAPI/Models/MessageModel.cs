using System;
using System.Net;

namespace FlutterBilibiliAppWebAPI.Models
{
    public class MessageModel<T>
    {
        public static MessageModel<T> CreateMessageModel(int code, string msg, T data)
        {
            return new MessageModel<T> { Code = code, Message = msg, Data = data };
        }

        public static MessageModel<T> Success(string msg = "success", T response = default)
        {
            return CreateMessageModel((int)HttpStatusCode.OK, msg, response);
        }

        public static MessageModel<T> Fail(string msg, T response)
        {
            return CreateMessageModel((int)HttpStatusCode.BadRequest, msg, response);
        }

        public int Code { get; set; }
        public string Message { get; set; }
        public T Data { get; set; }
        public override string ToString()
        {
            return $"code: {Code}, message: {Message}, data: {Data}";
        }
    }
}
