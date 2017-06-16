# containerdays

Demo repo for Container Days 2017 talk in Hamburg, Germany.

For more about habitat, visit https://habitat.sh

## PreReqs:
* Test Kitchen with Vagrant

  https://www.vagrantup.com/

  http://kitchen.ci/  or  https://downloads.chef.io/chefdk/stable

* Probably VirtualBox, ymmv

  https://www.virtualbox.org/


## To Run the Demos

### Ponyserve:

Ponyserve http is port-forwarded to the host on 9292.  
1. ``kitchen converge``
2. ``kitchen login``
3. ``./0-ponyserve.sh``

To change the message for ponyserve, edit the 0-ponyserve.sh file. To stop the app, use ``ctrl-c``.

### National Parks

National Parks is a Java+Tomcat application with a mongodb backend. The original description of this application is in a blog post, https://blog.chef.io/2016/09/07/deploy-java-web-app-on-tomcat-8-with-habitat/

This demo will run mongodb in a docker container while the java application runs in native habitat runtime. You'll want two logins to your host via ``kitchen login``, one for mongodb and one for java.

There are two forwarded ports. The main http interface for the java app is accessed at http://127.0.0.1:8080/national-parks while the habitat http is accessed at http://127.0.0.1:9631/

For example, the configuration for national-parks hab is http://127.0.0.1:9631/services/national-parks/default/config

  1. ``kitchen converge``
  2. ``kitchen login`` in two terminals
  3. First terminal, mongodb: ``./1-mongo-docker.sh``
    This will export the mongodb hab to docker.
  4. First terminal, mongodb: ``./2-mongo-run.sh``
    This will run the mongodb in docker.
  5. Second terminal, java: ``./3-natparks-run.sh``
  6. In a browser, http://127.0.0.1:8080/national-parks/

Sample output from running mongodb in docker:
```
Recreating vagrant_mongo_1
Attaching to vagrant_mongo_1
mongo_1  | hab-sup(MR): Supervisor Member-ID ea0c909186d446a8ac22f268a39ef81f
mongo_1  | hab-sup(MR): Starting nathenharvey/mongodb
mongo_1  | hab-sup(MR): Starting gossip-listener on 0.0.0.0:9638
mongo_1  | hab-sup(MR): Starting http-gateway on 0.0.0.0:9631
mongo_1  | mongodb.default(SR): Hooks recompiled
mongo_1  | mongodb.default(SR): Initializing
mongo_1  | mongodb.default(SV): Starting process as user=hab, group=hab
mongo_1  | mongodb.default(O): note: noprealloc may hurt performance in many applications
```

The final lines of output from Tomcat in habitat should indicate that the app has started successfully:
```
national-parks.default(O): 16-Jun-2017 14:32:20.004 INFO [localhost-startStop-1] org.apache.catalina.startup.HostConfig.deployDirectory Deployment of web application directory /hab/pkgs/core/tomcat8/8.5.9/20170215223900/tc/webapps/ROOT has finished in 50 ms
national-parks.default(O): 16-Jun-2017 14:32:20.031 INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler [http-nio-8080]
national-parks.default(O): 16-Jun-2017 14:32:20.037 INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler [ajp-nio-8009]
national-parks.default(O): 16-Jun-2017 14:32:20.064 INFO [main] org.apache.catalina.startup.Catalina.start Server startup in 3513 ms
```
