from db import UserDatabase
from flask.views import MethodView
from flask_smorest import Blueprint, abort
from marshmallow import ValidationError
from flask import send_from_directory, current_app
from datetime import datetime, timedelta
import os
#from schemas import AddDeviceSchema, UpdateUserDataSchema, UpdateDeviceScanSchema, UpdateMoistLimitSchema, ForgotPasswordSchema, AddMoistHistorySchema, AddNotificationSchema, EditDeviceSchema, GetDevicesByUserIdSchema, GetMoistHistorySchema, GetNotificationSchema, NotificationIdSchema, SignupSchema, SignupQuerySchema, LoginQuerySchema, LoginSchema, SubscribeQuerySchema, SubscribeSchema, SuccessMessageSchema, UpdateNotificationStatusSchema, UserDeleteSchema, UserDetailSchema, UserListSchema, UserLoginSchema, UpdateFlagSchema, UserLogoutSchema, UserSignupSchema, ViewDeviceHistorySchema
from schemas import (
    AddDeviceSchema,
    UpdateUserDataSchema,
    UpdateDeviceScanSchema,
    UpdateMoistLimitSchema,
    ForgotPasswordSchema,
    AddMoistHistorySchema,
    AddNotificationSchema,
    EditDeviceSchema,
    GetMillerSchema,
    GenerateQmsSchema,
    FetchMillerSchema,
    GetDevicesByUserIdSchema,
    GetMoistHistorySchema,
    GetNotificationSchema,
    NotificationIdSchema,
    SignupSchema,
    SignupQuerySchema,
    LoginQuerySchema,
    LoginSchema,
    CreateMillerSchema,
    SubscribeQuerySchema,
    SubscribeSchema,
    SuccessMessageSchema,
    UpdateNotificationStatusSchema,
    UserDeleteSchema,
    UserDetailSchema,
    UserListSchema,
    UserLoginSchema,
    UpdateFlagSchema,
    UserLogoutSchema,
    UserSignupSchema,
    ViewDeviceHistorySchema,
    SensorReadingSchema,
    SensorReadingListSchema,
    CiphetLoginSchema,
    ThresholdSchema,
    RoleSchema, CitySchema, UserSchema, ColdStorageSchema,
    BoxSchema, BoxSensorReadingSchema, DisconnectLogSchema, ThresholdBreachSchema, BoxSensorReadingCreateSchema, UpdateUserRoleSchema
)

import hashlib
from flask_jwt_extended import create_access_token, jwt_required, get_jwt
#from blocklist import BLOCKLIST
from flask import request, render_template
import json
from flask import Flask, render_template, request, jsonify
# import torch
#from transformers import AutoModelForCausalLM, AutoTokenizer
import smtplib, ssl
import uuid
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
# import razorpay
from datetime import datetime
from socketio_config import socketio
blp = Blueprint("Users", __name__, description="Operations on users")
#tokenizer = AutoTokenizer.from_pretrained("microsoft/DialoGPT-medium")
#model = AutoModelForCausalLM.from_pretrained("microsoft/DialoGPT-medium")
result_list = []
    
@blp.route("/add_user")
class UserSignup(MethodView):

    def __init__(self):
        self.db = UserDatabase()
    
    @blp.arguments(SignupSchema, location="json")
    def post(self, request_data):
        #request_data = request.get_json()
        #print(request_data)
        username = request_data['username']
        password = request_data['password']
        mobile = request_data['mobile']
        created_at = datetime.strptime(request_data['created_at'], '%d/%m/%Y %H:%M')
        last_login = datetime.strptime(request_data['last_login'], '%d/%m/%Y %H:%M')
        result = self.db.add_user(username,password,mobile,created_at,last_login)
        if result is None:
            abort(400, message="Username or password is incorrect")
        return result, 201


@blp.route("/user_login")
class UserLogin(MethodView):

    def __init__(self):
        self.db = UserDatabase()
    
    @blp.arguments(LoginSchema, location="json")
    def post(self, request_data):
        username = request_data['username']
        password = request_data['password']
        result = self.db.signin_user(username, password)
        if result is None:
            abort(404, message="Page Not Found")
        return result, 200
        
@blp.route("/update_flag")
class UserFlagUpdate(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    @blp.arguments(UpdateFlagSchema, location="json")
    def post(self, request_data):
        print("Incoming update payload:", request_data)

        userid = request_data.pop("userid", None)
        if not userid:
            abort(400, message="User ID is required")

        result = self.db.update_user_profile(userid, request_data)

        if result:
            return result, 200
        else:
            abort(400, message="Failed to update user profile")


@blp.route("/update_user_data")
class UserFlagUpdate(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    @blp.arguments(UpdateUserDataSchema, location="json")
    def post(self, request_data):
        print("Incoming update payload:", request_data)

        userid = request_data.pop("userid", None)
        if not userid:
            abort(400, message="User ID is required")

        result = self.db.update_user_data(userid, request_data)

        if result:
            return result, 200
        else:
            abort(400, message="Failed to update user profile")
    
@blp.route("/update_moist_limit")
class UserFlagUpdate(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    @blp.arguments(UpdateMoistLimitSchema, location="json")
    def post(self, request_data):
        print("Incoming update payload:", request_data)

        userid = request_data.pop("userid", None)
        if not userid:
            abort(400, message="User ID is required")

        result = self.db.update_moist_limit(userid, request_data)

        if result:
            return result, 200
        else:
            abort(400, message="Failed to update user profile")

@blp.route("/update_device_scan")
class DeviceScanUpdate(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    @blp.arguments(UpdateDeviceScanSchema, location="json")
    def post(self, request_data):
        try:
            print("Incoming update payload:", request_data)
            userid = request_data.get("userid")
            if not userid:
                abort(400, message="User ID is required")

            result = self.db.update_device_scan(userid, request_data)

            if result:
                return result, 200
            else:
                abort(400, message="Failed to update user profile")

        except ValidationError as e:
            print("Validation error:", e.messages)  # This prints any schema validation errors
            abort(400, message="Validation error: " + str(e.messages))
        except Exception as e:
            print("Error processing the request:", e)
            abort(500, message="Internal Server Error")
            
@blp.route("/update_password")
class PasswordUpdate(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    @blp.arguments(ForgotPasswordSchema, location="json")
    def post(self, request_data):
        print("Incoming update payload:", request_data)

        username = request_data.get("username")
        password = request_data.get("password")
        if not username:
            abort(400, message="User ID is required")

        result = self.db.update_user_password(username, password)

        if result:
            return {"message": "Password updated successfully"}, 200
        else:
            abort(400, message="Failed to update user profile")
    
@blp.route("/add_moisture")
class MoistureData(MethodView):

    def __init__(self):
        self.db = UserDatabase()

    @blp.arguments(AddMoistHistorySchema, location="json")
    def post(self, request_data):
        id = request_data['id']
        userid = request_data['userid']
        date = request_data['moistdate']
        commodity = request_data['commodity']
        lot = request_data['lot']
        stack = request_data['stack']
        moisture = request_data['moisture']
        temperature = request_data['temperature']
        humidity = request_data['humidity']
        depo = request_data['depo']
        deviceId = request_data['deviceId']
        millerid = request_data['millerid']
        millername = request_data['millername']
        qmsid = request_data['qms_id']
        result = self.db.add_moist_history(id, userid, date, commodity, lot, stack, moisture, temperature, humidity, depo, deviceId, qmsid, millerid, millername)

        if not result:
            abort(400, message="Failed to add moist history")

        return {"message": "Moisture history added successfully"}, 201

@blp.route("/add_moist", methods=["POST"])
class MoistData(MethodView):

    def __init__(self):
        self.db = UserDatabase()

    @blp.arguments(GetMoistHistorySchema, location="query")
    def post(self, request_data):
        userid = request_data['userid']
        records = self.db.get_moist_history_by_userid(userid)

        if not records:
            abort(404, message="No moisture history found for this user")

        return records, 200

@blp.route("/device")
class DeviceAPI(MethodView):

    def __init__(self):
        self.db = UserDatabase()

    # Add new device
    @blp.arguments(AddDeviceSchema, location="json")
    def post(self, request_data):
        userid = request_data['userid']
        deviceid = request_data['deviceid']
        devicename = request_data['devicename']
        macaddress = request_data['macaddress']
        charuuid = request_data['charuuid']
        status = request_data['status']

        result = self.db.add_device(userid, deviceid, devicename, macaddress, charuuid, status)

        if not result:
            abort(400, message="Failed to add device")

        return {"message": "Device added successfully"}, 201

    # Get all devices by user id
    @blp.arguments(GetDevicesByUserIdSchema, location="query")
    def get(self, request_data):
        userid = request_data['userid']
        devices = self.db.get_devices_by_userid(userid)

        if not devices:
            abort(404, message="No devices found for this user")

        return {"devices": devices}, 200

    # Edit device details
    @blp.arguments(EditDeviceSchema, location="json")
    def put(self, request_data):
        userid = request_data['userid']
        deviceid = request_data['deviceid']
        devicename = request_data['devicename']
        macaddress = request_data['macaddress']
        charuuid = request_data['charuuid']

        result = self.db.edit_device(userid, deviceid, devicename, macaddress, charuuid)

        if not result:
            abort(400, message="Failed to update device")

        return {"message": "Device updated successfully"}, 200

    # View moisture history by device id
    @blp.arguments(ViewDeviceHistorySchema, location="query")
    def patch(self, request_data):
        deviceid = request_data['deviceid']
        history = self.db.get_device_history(deviceid)

        if not history:
            abort(404, message="No moisture history found for this device")

        return {"device_history": history}, 200


@blp.route("/notification")
class NotificationView(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    @blp.arguments(AddNotificationSchema, location="json")
    def post(self, request_data):
        result = self.db.add_notification(**request_data)
        if not result:
            abort(400, message="Failed to add notification")
        return {"message": "Notification added successfully"}, 201

    @blp.arguments(GetNotificationSchema, location="query")
    def get(self, request_data):
        userid = request_data['userid']
        notifications = self.db.get_notifications_by_userid(userid)
        if not notifications:
            abort(404, message="No notifications found")
        return notifications, 200

    @blp.arguments(NotificationIdSchema, location="query")
    def delete(self, request_data):
        notification_id = request_data['notification_id']
        result = self.db.delete_notification_by_id(notification_id)
        if not result:
            abort(404, message="Notification not found")
        return {"message": "Notification deleted"}, 200

    @blp.arguments(UpdateNotificationStatusSchema, location="json")
    def patch(self, request_data):
        notification_id = request_data['notification_id']
        status = request_data['status']
        result = self.db.mark_notification_as_read(notification_id, status)
        if not result:
            abort(400, message="Failed to update notification status")
        return {"message": "Notification status updated"}, 200

@blp.route("/create_miller")
class CreateMillerView(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    @blp.arguments(CreateMillerSchema, location="json")
    def post(self, request_data):
        result = self.db.add_miller(request_data)
        if not result:
            abort(400, message="Failed to add miller")
        return {"message": "Miller added successfully"}, 201
        
    @blp.arguments(FetchMillerSchema, location="query")
    def get(self, request_data):
        result = self.db.get_miller(request_data)
        if not result:
            abort(400, message="Failed to get miller")
        return result, 200

@blp.route("/get_miller")
class GetMillerView(MethodView):
    def __init__(self):
        self.db = UserDatabase()
        
    @blp.arguments(GetMillerSchema, location="query")
    def get(self, request_data):
        result = self.db.get_miller_of_userid(request_data)
        if not result:
            abort(400, message="Failed to get miller")
        return result, 200

@blp.route("/generate_qms")
class GenerateQmsView(MethodView):
    def __init__(self):
        self.db = UserDatabase()
        
    @blp.arguments(GenerateQmsSchema, location="query")
    def get(self, request_data):
        result = self.db.generate_qms_of_userid(request_data)
        if not result:
            abort(400, message="Failed to get miller")
        return result, 200

@blp.route("/get_qms_id")
class GetQmsView(MethodView):
    def __init__(self):
        self.db = UserDatabase()
        
    @blp.arguments(GenerateQmsSchema, location="query")
    def get(self, request_data):
        result = self.db.get_qms_of_userid(request_data)
        if not result:
            abort(400, message="Failed to get miller")
        return result, 200
        
@blp.route("/firmware.bin")
class FirmwareDownloadView(MethodView):
    def get(self):
        try:
            # Assuming firmware is in a "firmware" subfolder in project root
            firmware_folder = os.path.join(current_app.root_path, 'firmware')
            return send_from_directory(firmware_folder, 'firmware.bin', as_attachment=True)
        except FileNotFoundError:
            abort(404, message="❌ firmware.bin not found")
            
            
# @blp.route('/ui-netpro-web')
# def index():
#     return render_template('nw_samvaad.html')


# @blp.route('/ui-netpro-login')
# def index():
#     return render_template('index.html')
    
# @blp.route('/nw_dashboard')
# def index():
#     return render_template('new_dashboard.html')


# @blp.route('/nw_sample')
# def index():
#     return render_template('ciphet_board.html')

@blp.route('/nw_ciphet')
def index():
    return render_template('test_board.html')

# @blp.route('/nw_analytics_login')
# def index():
#     return render_template('ciphet_login.html')
    
# @blp.route('/onion_sense_analytics')
# def index():
#     return render_template('data.html')

@blp.route("/add_sensor_reading")
class AddSensorReadingView(MethodView):
    
    def __init__(self):
        self.db = UserDatabase()
    @blp.arguments(SensorReadingSchema, location="json")
    def post(self, request_data):
        data = request_data
        success = self.db.add_sensor_reading(
            reading_time=request_data["reading_time"],
            sensor1=request_data["sensor1"],
            sensor2=request_data["sensor2"],
            sensor3=request_data["sensor3"],
            sensor4=request_data["sensor4"],
            temperature=request_data["temperature"],
            humidity=request_data["humidity"]
        )

        if not success:
            abort(400, message="❌ Failed to insert sensor reading")
        
        # Emit live reading via socket with all new fields
        socketio.emit("new_reading", {
            "reading_time": data["reading_time"],
            "sensor1": data["sensor1"],
            "sensor2": data["sensor2"],
            "sensor3": data["sensor3"],
            "sensor4": data["sensor4"],
            "sensor5": data.get("temperature"),
            "sensor6": data.get("humidity")
        })
        return {"message": "✅ Sensor reading inserted successfully"}, 200

@blp.route("/get_sensor_readings")
class GetSensorReadingsView(MethodView):

    def __init__(self):
        self.db = UserDatabase()

    @blp.response(200, SensorReadingListSchema(many=True))
    def get(self):
        readings = self.db.get_sensor_readings()
        return readings
        
@blp.route("/login_ciphet")
class UserLoginCiphet(MethodView):

    @blp.arguments(CiphetLoginSchema, location="json")
    def post(self, request_data):
        username = request_data.get("username")
        password = request_data.get("password")
        # Only allow admin/admin
        if username != "admin" or password != "admin":
            abort(401, message="Invalid username or password")

        # Create JWT token (expires in 1 hour)
        access_token = create_access_token(
            identity=username,
            expires_delta=timedelta(hours=6)
        )

        # Return token and info
        return {
            "access_token": access_token,
            "username": username,
            "last_login": datetime.now().strftime("%d/%m/%Y %H:%M")
        }, 200

# @blp.route("/get_thresholds")
# class GetThresholdsView(MethodView):

#     def __init__(self):
#         self.db = UserDatabase()

#     @blp.response(200, ThresholdSchema(many=True))
#     def get(self):
#         thresholds = self.db.get_sensor_thresholds()
#         return thresholds
# ---------------- Roles ----------------
@blp.route("/roles")
class RolesView(MethodView):

    def __init__(self):
        self.db = UserDatabase()

    @blp.response(200, RoleSchema(many=True))
    def get(self):
        return self.db.get_roles()

    @blp.arguments(RoleSchema, location="json")
    @blp.response(201, RoleSchema)
    def post(self, role_data):
        return self.db.add_role(role_data["name"], role_data.get("permissions"))

@blp.route("/roles/<int:role_id>")
class RoleDetailView(MethodView):

    def __init__(self):
        self.db = UserDatabase()

    @blp.arguments(RoleSchema, location="json")
    @blp.response(200, RoleSchema)
    def put(self, role_data, role_id):
        updated_role = self.db.update_role(role_id, role_data["name"], role_data.get("permissions"))
        if not updated_role:
            abort(404, message="Role not found")
        return updated_role
    
    @blp.response(204)
    def delete(self, role_id):
        result = self.db.delete_role(role_id)
        if not result:
            abort(404, message="Role not found")
        return '', 204

@blp.route("/sensor_readings")
class BoxSensorReadingsView(MethodView):

    def __init__(self):
        self.db = UserDatabase()

    @blp.response(200, BoxSensorReadingSchema(many=True))
    def get(self):
        readings = self.db.get_box_sensor_readings()
        return readings

    @blp.arguments(BoxSensorReadingCreateSchema, location="json")
    @blp.response(201, BoxSensorReadingSchema)
    def post(self, request_data):
        result = self.db.add_box_sensor_reading(
            box_id=request_data["box_id"],
            city_id=request_data["city_id"],
            user_id=request_data.get("user_id"),
            sensor1=request_data["sensor1"],
            sensor2=request_data["sensor2"],
            sensor3=request_data["sensor3"],
            sensor4=request_data["sensor4"],
            sensor5=request_data["sensor5"],
            sensor6=request_data["sensor6"]
        )
        if not result:
            abort(400, message="Failed to add box sensor reading")
        return result
    
    # ---------------- Cities ----------------
@blp.route("/cities")
class CitiesView(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    @blp.response(200, CitySchema(many=True))
    def get(self):
        return self.db.get_cities()

    @blp.arguments(CitySchema, location="json")
    @blp.response(201, CitySchema)
    def post(self, city_data):
        return self.db.add_city(city_data["name"], city_data.get("country"), city_data.get("timezone"))

@blp.route("/cities/<int:city_id>")
class CityDetailView(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    @blp.arguments(CitySchema, location="json")
    @blp.response(200, CitySchema)
    def put(self, city_data, city_id):
        updated = self.db.update_city(city_id, city_data["name"], city_data.get("country"), city_data.get("timezone"))
        if not updated:
            abort(404, message="City not found")
        return updated

    @blp.response(204)
    def delete(self, city_id):
        success = self.db.delete_city(city_id)
        if not success:
            abort(404, message="City not found")
        return '', 204

# ---------------- Boxes ----------------
@blp.route("/boxes")
class BoxesView(MethodView):
    def __init__(self):
        self.db = UserDatabase()
    

    # @jwt_required()
    @blp.response(200, BoxSchema(many=True))
    def get(self):
        # Get the current logged-in user's username or id from JWT
        # current_user = get_jwt_identity()
        current_user = "anurag666"
        # Fetch boxes for that particular user
        return self.db.get_boxes(current_user)
    
    # @jwt_required()
    @blp.arguments(BoxSchema, location="json")
    @blp.response(201, BoxSchema)
    def post(self, box_data):
        verify_jwt_in_request()
        # current_user = get_jwt_identity()
        current_user = "anurag666"
        # Pass current_user to add_box so user_id is set automatically
        return self.db.add_box(
            box_data["name"], 
            box_data["cold_storage_id"], 
            box_data.get("capacity"), 
            current_user
        )

@blp.route("/boxes/<int:box_id>")
class BoxDetailView(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    @blp.arguments(BoxSchema, location="json")
    @blp.response(200, BoxSchema)
    def put(self, box_data, box_id):
        updated = self.db.update_box(box_id, box_data["name"], box_data["cold_storage_id"], box_data.get("capacity"))
        if not updated:
            abort(404, message="Box not found")
        return updated

    @blp.response(204)
    def delete(self, box_id):
        success = self.db.delete_box(box_id)
        if not success:
            abort(404, message="Box not found")
        return '', 204
    
# ---------------- Cold Storages ----------------
@blp.route("/cold_storages")
class ColdStoragesView(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    # @jwt_required()
    @blp.response(200, ColdStorageSchema(many=True))
    def get(self):
        # verify_jwt_in_request()
        # current_user = get_jwt_identity()
        current_user = "anurag666"
        return self.db.get_cold_storages(current_user)

    @blp.arguments(ColdStorageSchema, location="json")
    @blp.response(201, ColdStorageSchema)
    def post(self, cs_data):
        return self.db.add_cold_storage(cs_data["name"], cs_data.get("city_id"), cs_data.get("address"))

@blp.route("/cold_storages/<int:cs_id>")
class ColdStorageDetailView(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    @blp.arguments(ColdStorageSchema, location="json")
    @blp.response(200, ColdStorageSchema)
    def put(self, cs_data, cs_id):
        updated = self.db.update_cold_storage(cs_id, cs_data["name"], cs_data.get("city_id"), cs_data.get("address"))
        if not updated:
            abort(404, message="Cold storage not found")
        return updated

    @blp.response(204)
    def delete(self, cs_id):
        success = self.db.delete_cold_storage(cs_id)
        if not success:
            abort(404, message="Cold storage not found")
        return '', 204

# ---------------- Users ----------------
# @blp.route("/users")
# class UsersView(MethodView):
#     def __init__(self):
#         self.db = UserDatabase()

#     @blp.response(200, UserSchema(many=True))
#     def get(self):
#         return self.db.get_users()

#     @blp.arguments(UserSchema, location="json")
#     @blp.response(201, UserSchema)
#     def post(self, user_data):
#         hashed_password = generate_password_hash(user_data["password"])
#         return self.db.add_user(user_data["name"], user_data["email"], hashed_password, user_data.get("role_id"), user_data.get("city_id"), user_data.get("mobile"))
# ---------------- Users ----------------
@blp.route("/users")
class UsersView(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    @blp.response(200, UserSchema(many=True))
    def get(self):
        return self.db.get_users()

    
    @blp.arguments(UserSchema, location="json")
    @blp.response(201, UserSchema)
    def post(self, user_data):
        print("UserMobile:"+user_data.get("mobile_no"))
        hashed_password = generate_password_hash(user_data["password"])
        return self.db.add_user_onion_sense(user_data["name"], user_data["email"], hashed_password, user_data.get("role_id"), user_data.get("city_id"), user_data.get("mobile_no"),user_data.get("parent_id"))

@blp.route("/users/<int:user_id>")
class UserDetailView(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    @blp.arguments(UserSchema, location="json")
    @blp.response(200, UserSchema)
    def put(self, user_data, user_id):
        updated = self.db.update_user(user_id, user_data["name"], user_data["email"], user_data.get("password"), user_data.get("role_id"), user_data.get("city_id"))
        if not updated:
            abort(404, message="User not found")
        return updated

    @blp.response(204)
    def delete(self, user_id):
        success = self.db.delete_user(user_id)
        if not success:
            abort(404, message="User not found")
        return '', 204

# ---------------- Signup ----------------
@blp.route("/signup", methods=["POST"])
def signup():
    data = request.get_json()
    username = data.get("username")
    email = data.get("email")
    password = data.get("password")
    mobile = data.get("mobile")

    if not username or not email or not password or not mobile:
        return jsonify({"msg": "All fields are required"}), 400

    hashed_password = generate_password_hash(password)
    db = UserDatabase()
    user = db.add_user(username, email, hashed_password, mobile=mobile)

    if not user:
        return jsonify({"msg": "Failed to create user"}), 500

    return jsonify({
        "id": user["id"],
        "username": user["name"],
        "email": user["email"],
        "mobile": user["mobile_no"],
        "role_id": user["role_id"],   # None at start
        "city_id": user["city_id"],   # None at start
        "created_at": str(user["created_at"])
    }), 201

# ---------------- Disconnect Logs ----------------
@blp.route("/disconnect-logs")
class DisconnectLogsView(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    # @jwt_required()
    @blp.response(200, DisconnectLogSchema(many=True))  # Schema you need to create
    def get(self):
        # current_user = get_jwt_identity()
        current_user = "anurag666"
        # Fetch disconnect logs for the current user
        return self.db.get_disconnect_logs(current_user)
    

# ---------------- Threshold Breaches ----------------
@blp.route("/threshold-breaches")
class ThresholdBreachesView(MethodView):
    def __init__(self):
        self.db = UserDatabase()

    # @jwt_required()
    @blp.response(200, ThresholdBreachSchema(many=True))
    def get(self):
        # current_user = get_jwt_identity()
        current_user = "anurag666"
        breaches = self.db.get_threshold_breaches(current_user)
        return breaches

# ---------------- Threshold Breaches ----------------
# ---------------- Threshold Breaches ----------------
@blp.route("/update_user_role")
class UpdateUserRoleView(MethodView):
    def __init__(self):
        self.db = UserDatabase()  # Your database access class

    @blp.arguments(UpdateUserRoleSchema)
    @blp.response(200)
    def post(self, args):
        userid = args["userid"]
        parentid = args["parentid"]
        new_role_id = args["new_role_id"]

        # Check parent (admin) user exists with role permissions
        admin_user = self.db.get_user_with_role_permissions(parentid)
        if not admin_user:
            return {"error": "Admin user not found"}, 404

        # Check if admin has permission to edit users
        if not admin_user["permissions"].get("edit_user", False):
            return {"error": "Not authorized to update user roles"}, 403

        # Fetch the target user
        target_user = self.db.get_user_with_role_permissions(userid)
        if not target_user:
            return {"error": "Target user not found"}, 404

        # Update role
        self.db.update_user_role(userid, new_role_id)

        return {
            "message": f"User {target_user['name']}'s role updated successfully",
            "user_id": userid,
            "new_role_id": new_role_id
        }
