
//resource "datadog_synthetics_test" "beacon" {
//  type    = "api"
//  subtype = "http"
//
//  request_definition {
//    method = "GET"
//    url    = "http://a772039f13f424c45b7e40ab7709415d-540684085.eu-west-1.elb.amazonaws.com:8080"
//  }
//
//  assertion {
//    type     = "statusCode"
//    operator = "is"
//    target   = "200"
//  }
//
//  locations = ["aws:eu-west-1"]
//  options_list {
//    tick_every          = 900
//    min_location_failed = 1
//  }
//
//  name    = "Dev ELB API Check"
//  message = "Oh no! Light from the Beacon app is no longer shining!"
//  tags    = ["app:beacon", "env:demo"]
//
//  status = "live"
//
////  request = {}
//}
