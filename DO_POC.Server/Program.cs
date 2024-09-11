using DO_POC.Server.Models;
using DO_POC.Server.Services;
using Microsoft.AspNetCore.Http.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Text.Json;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);
var configuration = builder.Configuration;

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddDbContext<AppDBContext>(opts =>
{
    opts.UseMySQL(configuration.GetConnectionString("db"));
});

builder.Services.AddScoped<IDBRepository, DBRepository>();

builder.Services.Configure<Microsoft.AspNetCore.Http.Json.JsonOptions>(opts =>
{
    opts.SerializerOptions.PropertyNameCaseInsensitive = true;
    opts.SerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles;
});

var app = builder.Build();

app.UseDefaultFiles();
app.UseStaticFiles();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.MapGet("/locations", (IDBRepository db) =>
{
    var locations = db.ReadAllLocations();
    return locations;
})
.WithName("GetLocations")
.WithOpenApi();

app.MapGet("/samples", (IDBRepository db) =>
{
    var samples = db.ReadAllSamples();
    return samples;
})
.WithName("GetSamples")
.WithOpenApi();

app.MapGet("/results", (IDBRepository db) =>
{
    var results = db.ReadAllResults();
    return results;
})
.WithName("GetResults")
.WithOpenApi();

app.MapPost("/upload", (List<Sample> samples, IDBRepository db) =>
{
    return db.AddSamples(samples);
});

app.MapFallbackToFile("/index.html");

app.Run();
