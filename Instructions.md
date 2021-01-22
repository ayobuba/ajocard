AjoCard DevOps and SRE Engineering Challenge
==============================================

Welcome to your challenge project!

Guidelines
- Think through the challenge, make a rough plan of your approach, and write up answers to all the follow-up questions.
- Send us your results within 3 days. If you need more time, please let us know.
- We estimate this should take somewhere between 2 and 10 hours depending on your experience and speed.


Motivation
----------

AjoCard's infrastructure must deliver swift responses to its thousands of customers while maintaining virtually 0 downtime. We persist application logs more or less forever, frequently deploy new code multiple times per day, and must meet certain industry compliance standards in the coming months (PCI, etc). In order to tackle these challenges and many more, we rely on our team members' ability to reason about and design such systems, both conceptually and concretely, from a bird's eye perspective as well as in great detail.

Your challenge is to design and implement 0-downtime deployment for two simple HTTP servers (Go & NodeJS), and then discuss a few questions around systems engineering, InnoDB schemas, MongoDB, downtime monitoring, and logging.

If we mutually agree to proceed then your work will form the basis for continued discussions and interviews.


Thoughts and recommendations before we go into details
------------------------------------------------------

- Use the tools and languages that you're most familiar with.
- We really value legible code and well organized file directories.
- Opt for using open source libraries rather than reinventing any wheels.
- It's a plus if your results come with a version control commit history.
- Think cloud-native.


Challenge equirements
---------------------

1. Put together two basic HTTP applications - one in Go, and one in NodeJS.

   - Keep them as simple as possible, e.g responding "Hi!" to every request is sufficient.
   - Use any HTTP libraries you want, e.g http/net for Go, Fastify for NodeJS.
   - To simulate long-lived connections, you may want to put a random `sleep` in there.
   - This is basically just the setup for the challenge - write as little code as possible :)

2. Setup a deployment pipeline and deployment script(s) for the apps.

   - You will need to deploy your project using Docker/Kubernetes. Please provide a README along with the link to your project
   - You will also need to provide the manifests for deploying the server onto a Kubernetes cluster. (e.g. deployment, service, ingress).
   - You can use Bitbucket Pipelines, Gitlab CI, Github Actions or any other tool you are comfortable with.
   - It should be invoked with something like `./deploy-apps go-app node-app`
   - It should be able to deploy one or multiple apps
   - It ahould install all required app dependencies are installed on the target container.
   - When deploying a new app version, open connections to the old server version must not be interrupted


Follow-up questions
-------------------

Please take the time to write answers to these questions. Think through them deeply, but keep answers short and comprehensive when possible.

Our goal is to get a sense how deep and broad your understand of systems like ours is, and how effectively you can communicate about them. Don't worry if you don't have all the answers off the top of your head: we're also very much looking for your ability to reason about these sorts of problems, and design/evaluate possible answers.

1. InnoDB clusters data in its primary key B+Tree. As a result, "natural primary key" tables and "auto-increment primary key" tables have 
   different characteristics. In a few words, how would you describe the differences? 
   Also, give at least one examples of when you would use natural keys over auto-incrementing ones.

2. We strive for virtually 0 downtime, but issues do happen. If/when disaster strikes we have to respond immediately. 
   Please take the time to describe how you would structure downtime alerts and human response protocols at a company like AjoCard in order 
   to sleep soundly at night.
   
   I would utilize a cloud notification services like AWS SNS for Application to application(A2A) and application to person (A2P). A serverless 
   function will probe the main application for Healthchecks failures and when a healthcheck fails, a notification can be sent to Human using A2P
   and the same notification can also be sent to another function triggering url swap to a different availability zone where the application is also 
   running like a Blue/Green Deployment.
   

3. Kubernetes managament can be seen to be daunting. We run our application workloads in Kubernetes environment(s). 
   If/when a worker node(s) becomes unreachable or unavailable, we have to respond immediately.  
   Please take the time to describe how you would structure downtime alerts for Kubernetes nodes and how you would respond to prevent 
   and /or maintain an objective of 0 downtime.
   
   Depending on the cluster configuration, but in my opinion, the Launch Configuration and autoscaling group should take care of 
   provisioning a new node . If the node consistently fails a health check, an email notification service like SES can be utilized 
   to send notifications if node provisioning failures.
   


4. Logs can be fantastic, and logs can be a headache. We have applications written in multiple languages, 
   with multiple versions of each running in parallel on multiple pods / containers that can be torn down and spun up at any time. 
   In addition, PCI compliance requires long-lived access logs of all production services. 
   How would you structure logging for this whole system?
   
I would provision a Prometheus server on the kubernetes cluster that will monitor  and show overall cluster filesystem usage,
individual systemd services, pod, containers statistics. Grafana will be used for analytics . PromQL will be used to aggregate time series data 
and stored in an S3 bucket.

5. How do you feel about being point person and in-house expert on compliance? (PCI, etc.)
   Its  a task I will know i will be competent in as long as i am deeply familiar with the inhouse compliance policies 

**Follow these instructions to submit your challenge.**
- Write your code on a separate branch on a private Github repository
- Commit your changes
- Issue a Pull Request
- Invite us (Github: "ajocardeng") as a collaborator to your repository.
- Respond to the follow-up via the email thread that you received this challenge.
