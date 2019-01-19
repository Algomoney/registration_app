#r "Newtonsoft.Json"

using System.Net;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;

public static async Task<IActionResult> Run(HttpRequest req, ILogger log)
{
    log.LogInformation("C# HTTP trigger function processed a request.");

    string photo = req.Query["photo"];
    string name = req.Query["name"];
    string email = req.Query["email"];
    string password = req.Query["password"];
    string age = req.Query["age"];
    string gender = req.Query["gender"];

    string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
    dynamic data = JsonConvert.DeserializeObject(requestBody);
    name = name ?? data?.name;
    email = email ?? data?.email;
    log.LogInformation($"Name: {name}");
    log.LogInformation($"Email: {email}");

    return name != null
        ? (ActionResult)new OkObjectResult($"Hello, {name}. Your email is: {email}")
        : new BadRequestObjectResult("Please pass a name on the query string or in the request body");
}
