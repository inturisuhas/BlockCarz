// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;
contract Car {
   uint VIN = 76767162;
   string report;
   address payable private vehicleManufacturerAddress; // Address of Vehicle Manufacturer
   // Holds details of owner
   struct ownership {
        uint drivingLicenseNumber; // unique DL of the owner
        string name; // Name of the owner
        bool alive;  // if true, the person is still alive
        address delegate; // address that's delegated to modify the details(RMV)
   }
    ownership[] ownershipArray;
   // Holds details of any ticketing, traffic incidents
   // Can only be appended by Police
   struct ticketingDetails{
        string location; // Place where incident happened 
        uint price; // How much was the person charged
        address delegate; // address that's delegated to modify the details(police)
   }
   ticketingDetails[] ticketingDetailsArray;
   // Holds details of any repairs done
   // Can only be appended by Maintenance plants
   struct maintenanceDetails{
        uint coolant; // Holds information on amount of coolant
        uint brakes; // Holds information on what's the brakes pressure
        string engineOilStatus; // What is the condition of engine oil
        string batteryStatus; // battery status
        uint milesDriven; // number of miles driven till date
        address delegate; // address that's delegated to modify the details(maintenance plants)
   }

   maintenanceDetails[] maintenanceDetailsArray;

   // Holds details of the initial car make
   // Can only be added by Vehicle Manufacturers
    struct initialData{
        uint VIN; // Vehicle Id Number
        string carName; // name of the car
        string manufacturedDate; // date of manufacturing
        string model; // car model
        //...Any other details..//
    }

   // Holds details of the information gained through IoT sensors via ODB ports
   // Can only be added by Oracles
    struct obdPorts{
        uint odometer; // odometer reading
        string carName; // name of the car
        string manufacturedDate; // date of manufacturing
        string model; // car model
        //...Any other details..//
    }
    obdPorts[] obdPortsArray;
   // Initiates the contract
   // Only a vehicle Manufacturer can call this API
   constructor (initialData memory defaultData) {
    VIN = defaultData.VIN;
   }
   // This API can be called only by police
   // This API will append all the ticketing, traffic details
   function appendTicketingDetails(ticketingDetails memory data) public {
       ticketingDetailsArray.push(data);
   }
   // This API can be called only by maintenance plants
   // This API will append all the maintenance details
   function appendMaintenanceDetails(maintenanceDetails memory data) public {
       maintenanceDetailsArray.push(data);
   }
   // This API can be called only by RMVs
   // This API will append all the ownership details
   function appendOwnershipDetails(ownership memory data) public {
       ownershipArray.push(data);
   }
   // This API can be called only by OBD ports
   // This API will append all the car details in real time
   function appendCarDetails(obdPorts memory data) public {
       obdPortsArray.push(data);
   }
   // This API generates report 
   function getReport() public view returns (string memory) {
       return report;
   }
   // This API will destruct the smart Contract
   // Only RMVs can call this API
   function done() public {
        selfdestruct(vehicleManufacturerAddress);
   }
}
