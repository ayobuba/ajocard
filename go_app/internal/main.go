package main

import (
	"github.com/go-openapi/loads"
	"github.com/go-openapi/runtime/middleware"
	"github.com/scraly/http-go-server/pkg/swagger/server/restapi"
	"github.com/scraly/http-go-server/pkg/swagger/server/restapi/operations"
	"log"
)

func main() {
	// Initialize Swagger
	swaggerSpec, err := loads.Analyzed(restapi.SwaggerJSON, "")
	if err != nil {
		log.Fatalln(err)
	}

	api := operations.NewHelloAPI(swaggerSpec)
	server := restapi.NewServer(api)

	defer func() {
		if err := server.Shutdown(); err != nil {
			log.Fatalln(err)
		}
	}()

	server.Port = 8082

	api.CheckHealthHandler = operations.CheckHealthHandlerFunc(
		func(user operations.CheckHealthParams) middleware.Responder {
			return operations.NewCheckHealthOK().WithPayload("OK")
		})
	api.GetHelloUserHandler = operations.GetHelloUserHandlerFunc(
		func(user operations.GetHelloUserParams) middleware.Responder {
			return operations.NewGetHelloUserOK().WithPayload("hello " + user.User + "!")

		})

	if err := server.Serve(); err != nil {
		log.Fatalln(err)
	}
}

//func main() {
//	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
//		fmt.Fprintf(w, "Hello, %q", html.EscapeString(r.URL.Path))
//
//	})
//	log.Println("Listening on localhost:8080")
//	log.Fatal(http.ListenAndServe(":8080", nil))
//}
//
