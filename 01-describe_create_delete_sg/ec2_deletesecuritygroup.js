// Load the AWS SDK for Node.js
var AWS = require('aws-sdk');
// Set the region 
AWS.config.update({region: 'REGION'});

// Create EC2 service object
var ec2 = new AWS.EC2({apiVersion: '2016-11-15'});

var params = {
   GroupId: 'SECURITY_GROUP_ID'
};

// Delete the security group
ec2.deleteSecurityGroup(params, function(err, data) {
   if (err) {
      console.log("Error", err);
   } else {
      console.log("Security Group Deleted");
   }
});
