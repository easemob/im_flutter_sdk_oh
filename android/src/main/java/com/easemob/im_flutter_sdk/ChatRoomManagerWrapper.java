package com.easemob.im_flutter_sdk;

import com.hyphenate.EMChatRoomChangeListener;
import com.hyphenate.EMError;
import com.hyphenate.EMResultCallBack;
import com.hyphenate.chat.EMChatRoom;
import com.hyphenate.chat.EMClient;
import com.hyphenate.chat.EMCursorResult;
import com.hyphenate.chat.EMPageResult;
import com.hyphenate.exceptions.HyphenateException;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;


public class ChatRoomManagerWrapper extends Wrapper implements MethodChannel.MethodCallHandler {

    private EMChatRoomChangeListener chatRoomChangeListener;

    ChatRoomManagerWrapper(FlutterPlugin.FlutterPluginBinding flutterPluginBinding, String channelName) {
        super(flutterPluginBinding, channelName);
        registerEaseListener();
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {

        JSONObject param = (JSONObject) call.arguments;
        try {
            if (MethodKey.joinChatRoom.equals(call.method)) {
                joinChatRoom(param, call.method, result);
            } else if (MethodKey.leaveChatRoom.equals(call.method)) {
                leaveChatRoom(param, call.method, result);
            } else if (MethodKey.fetchPublicChatRoomsFromServer.equals(call.method)) {
                fetchPublicChatRoomsFromServer(param, call.method, result);
            } else if (MethodKey.fetchChatRoomInfoFromServer.equals(call.method)) {
                fetchChatRoomInfoFromServer(param, call.method, result);
            } else if (MethodKey.getChatRoom.equals(call.method)) {
                getChatRoom(param, call.method, result);
            } else if (MethodKey.getAllChatRooms.equals(call.method)) {
                getAllChatRooms(param, call.method, result);
            } else if (MethodKey.createChatRoom.equals(call.method)) {
                createChatRoom(param, call.method, result);
            } else if (MethodKey.destroyChatRoom.equals(call.method)) {
                destroyChatRoom(param, call.method, result);
            } else if (MethodKey.changeChatRoomSubject.equals(call.method)) {
                changeChatRoomSubject(param, call.method, result);
            } else if (MethodKey.changeChatRoomDescription.equals(call.method)) {
                changeChatRoomDescription(param, call.method, result);
            } else if (MethodKey.fetchChatRoomMembers.equals(call.method)) {
                fetchChatRoomMembers(param, call.method, result);
            } else if (MethodKey.muteChatRoomMembers.equals(call.method)) {
                muteChatRoomMembers(param, call.method, result);
            } else if (MethodKey.unMuteChatRoomMembers.equals(call.method)) {
                unMuteChatRoomMembers(param, call.method, result);
            } else if (MethodKey.changeChatRoomOwner.equals(call.method)) {
                changeChatRoomOwner(param, call.method, result);
            } else if (MethodKey.addChatRoomAdmin.equals(call.method)) {
                addChatRoomAdmin(param, call.method, result);
            } else if (MethodKey.removeChatRoomAdmin.equals(call.method)) {
                removeChatRoomAdmin(param, call.method, result);
            } else if (MethodKey.fetchChatRoomMuteList.equals(call.method)) {
                fetchChatRoomMuteList(param, call.method, result);
            } else if (MethodKey.removeChatRoomMembers.equals(call.method)) {
                removeChatRoomMembers(param, call.method, result);
            } else if (MethodKey.blockChatRoomMembers.equals(call.method)) {
                blockChatRoomMembers(param, call.method, result);
            } else if (MethodKey.unBlockChatRoomMembers.equals(call.method)) {
                unBlockChatRoomMembers(param, call.method, result);
            } else if (MethodKey.fetchChatRoomBlockList.equals(call.method)) {
                fetchChatRoomBlockList(param, call.method, result);
            } else if (MethodKey.updateChatRoomAnnouncement.equals(call.method)) {
                updateChatRoomAnnouncement(param, call.method, result);
            } else if (MethodKey.fetchChatRoomAnnouncement.equals(call.method)) {
                fetchChatRoomAnnouncement(param, call.method, result);
            } else if (MethodKey.addMembersToChatRoomWhiteList.equals(call.method)) {
                addMembersToChatRoomWhiteList(param, call.method, result);
            } else if (MethodKey.removeMembersFromChatRoomWhiteList.equals(call.method)) {
                removeMembersFromChatRoomWhiteList(param, call.method, result);
            } else if (MethodKey.isMemberInChatRoomWhiteListFromServer.equals(call.method)) {
                isMemberInChatRoomWhiteListFromServer(param, call.method, result);
            } else if (MethodKey.fetchChatRoomWhiteListFromServer.equals(call.method)) {
                fetchChatRoomWhiteListFromServer(param, call.method, result);
            } else if (MethodKey.muteAllChatRoomMembers.equals(call.method)) {
                muteAllChatRoomsMembers(param, call.method, result);
            } else if (MethodKey.unMuteAllChatRoomMembers.equals(call.method)) {
                unMuteAllChatRoomsMembers(param, call.method, result);
            } else if (MethodKey.fetchChatRoomAttributes.equals(call.method)){
                fetchChatRoomAttributes(param, call.method, result);
            } else if (MethodKey.setChatRoomAttributes.equals(call.method)){
                setChatRoomAttributes(param, call.method, result);
            } else if (MethodKey.removeChatRoomAttributes.equals(call.method)){
                removeChatRoomAttributes(param, call.method, result);
            } else if (MethodKey.isMemberInChatRoomMuteList.equals(call.method)){
                isMemberInChatRoomMuteList(param, call.method, result);
            } else {
                super.onMethodCall(call, result);
            }
        } catch (JSONException ignored) {

        }
    }

    private void joinChatRoom(JSONObject param, String channelName, MethodChannel.Result result) throws JSONException {
        String roomId = param.getString("roomId");
        String ext = param.optString("ext");
        Boolean leaveOther = param.optBoolean("leaveOtherRooms");
        EMValueWrapperCallBack<EMChatRoom> callBack = new EMValueWrapperCallBack<EMChatRoom>(result, channelName) {
            @Override
            public void onSuccess(EMChatRoom object) {
                updateObject(ChatRoomHelper.toJson(object));
            }
        };

        EMClient.getInstance().chatroomManager().joinChatRoom(roomId, leaveOther, ext, callBack);
    }

    private void leaveChatRoom(JSONObject param, String channelName, MethodChannel.Result result) throws JSONException {
        String roomId = param.getString("roomId");

        asyncRunnable(() -> {
            EMClient.getInstance().chatroomManager().leaveChatRoom(roomId);
            onSuccess(result, channelName, true);
        });
    }

    private void fetchPublicChatRoomsFromServer(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        int pageNum = param.getInt("pageNum");
        int pageSize = param.getInt("pageSize");

        EMClient.getInstance().chatroomManager().asyncFetchPublicChatRoomsFromServer(pageNum, pageSize,
                new EMValueWrapperCallBack<EMPageResult<EMChatRoom>>(result, channelName) {
                    @Override
                    public void onSuccess(EMPageResult object) {
                        updateObject(PageResultHelper.toJson(object));
                    }

                    @Override
                    public void onError(int code, String desc) {
                        super.onError(code, desc);
                    }
                });
    }

    private void fetchChatRoomInfoFromServer(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        boolean fetchMembers = param.getBoolean("fetchMembers");
        asyncRunnable(() -> {
            EMChatRoom room = null;
            try {
                if (fetchMembers) {
                    room = EMClient.getInstance().chatroomManager().fetchChatRoomFromServer(roomId, true);
                }else {
                    room = EMClient.getInstance().chatroomManager().fetchChatRoomFromServer(roomId);
                }
                onSuccess(result, channelName, ChatRoomHelper.toJson(room));
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void getChatRoom(JSONObject param, String channelName, MethodChannel.Result result) throws JSONException {
        String roomId = param.getString("roomId");

        asyncRunnable(() -> {
            EMChatRoom room = EMClient.getInstance().chatroomManager().getChatRoom(roomId);
            onSuccess(result, channelName,room != null ? ChatRoomHelper.toJson(room) : null);
        });
    }

    private void getAllChatRooms(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        asyncRunnable(() -> {
            List<EMChatRoom> list = EMClient.getInstance().chatroomManager().getAllChatRooms();
            List<Map<String, Object>> roomList = new ArrayList<>();
            for (EMChatRoom room : list) {
                roomList.add(ChatRoomHelper.toJson(room));
            }
            onSuccess(result, channelName, roomList);
        });
    }

    private void createChatRoom(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String subject = param.getString("subject");
        int maxUserCount = param.getInt("maxUserCount");
        String description = null;
        if (param.has("desc")){
            description = param.getString("desc");
        }
        String welcomeMessage = null;
        if (param.has("welcomeMsg")){
            welcomeMessage = param.getString("welcomeMsg");
        }
        List<String> membersList = new ArrayList<>();
        JSONArray members = null;
        if (param.has("members")){
            members = param.getJSONArray("members");
            for (int i = 0; i < members.length(); i++) {
                membersList.add((String) members.get(i));
            }
        }

        String finalDescription = description;
        String finalWelcomeMessage = welcomeMessage;
        asyncRunnable(() -> {
            try {
                EMChatRoom room = EMClient.getInstance().chatroomManager().createChatRoom(subject, finalDescription,
                        finalWelcomeMessage, maxUserCount, membersList);
                onSuccess(result, channelName, ChatRoomHelper.toJson(room));
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void destroyChatRoom(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");

        asyncRunnable(() -> {
            try {
                EMClient.getInstance().chatroomManager().destroyChatRoom(roomId);
                onSuccess(result, channelName, true);
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void changeChatRoomSubject(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        String subject = param.getString("subject");

        asyncRunnable(() -> {
            try {
                EMChatRoom room = EMClient.getInstance().chatroomManager().changeChatRoomSubject(roomId, subject);
                onSuccess(result, channelName, ChatRoomHelper.toJson(room));
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void changeChatRoomDescription(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        String description = param.getString("description");

        asyncRunnable(() -> {
            try {
                EMChatRoom room = EMClient.getInstance().chatroomManager().changeChatroomDescription(roomId,
                        description);
                onSuccess(result, channelName, ChatRoomHelper.toJson(room));
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void fetchChatRoomMembers(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        String cursor = null;
        if(param.has("cursor")) {
            cursor = param.getString("cursor");
        }
        int pageSize = param.getInt("pageSize");

        String finalCursor = cursor;
        asyncRunnable(() -> {
            try {
                EMCursorResult<String> cursorResult = EMClient.getInstance().chatroomManager()
                        .fetchChatRoomMembers(roomId, finalCursor, pageSize);
                onSuccess(result, channelName, CursorResultHelper.toJson(cursorResult));
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void muteChatRoomMembers(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        long duration = param.getLong("duration");
        JSONArray muteMembers = param.getJSONArray("muteMembers");
        List<String> muteMembersList = new ArrayList<>();
        for (int i = 0; i < muteMembers.length(); i++) {
            muteMembersList.add((String) muteMembers.get(i));
        }

        asyncRunnable(() -> {
            try {
                EMChatRoom room = EMClient.getInstance().chatroomManager().muteChatRoomMembers(roomId, muteMembersList,
                        duration);
                onSuccess(result, channelName, ChatRoomHelper.toJson(room));
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void unMuteChatRoomMembers(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        JSONArray muteMembers = param.getJSONArray("unMuteMembers");
        List<String> unMuteMembersList = new ArrayList<>();
        for (int i = 0; i < muteMembers.length(); i++) {
            unMuteMembersList.add((String) muteMembers.get(i));
        }

        asyncRunnable(() -> {
            try {
                EMChatRoom room = EMClient.getInstance().chatroomManager().unMuteChatRoomMembers(roomId,
                        unMuteMembersList);
                onSuccess(result, channelName, ChatRoomHelper.toJson(room));
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void changeChatRoomOwner(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        String newOwner = param.getString("newOwner");

        asyncRunnable(() -> {
            try {
                EMChatRoom room = EMClient.getInstance().chatroomManager().changeOwner(roomId, newOwner);
                onSuccess(result, channelName, ChatRoomHelper.toJson(room));
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void addChatRoomAdmin(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        String admin = param.getString("admin");

        asyncRunnable(() -> {
            try {
                EMChatRoom room = EMClient.getInstance().chatroomManager().addChatRoomAdmin(roomId, admin);
                onSuccess(result, channelName, ChatRoomHelper.toJson(room));
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void removeChatRoomAdmin(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        String admin = param.getString("admin");

        asyncRunnable(() -> {
            try {
                EMChatRoom room = EMClient.getInstance().chatroomManager().removeChatRoomAdmin(roomId, admin);
                onSuccess(result, channelName, ChatRoomHelper.toJson(room));
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void fetchChatRoomMuteList(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        int pageNum = param.getInt("pageNum");
        int pageSize = param.getInt("pageSize");

        asyncRunnable(() -> {
            try {
                Map map = EMClient.getInstance().chatroomManager().fetchChatRoomMuteList(roomId, pageNum, pageSize);
                onSuccess(result, channelName, map.keySet().toArray());
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void removeChatRoomMembers(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        JSONArray members = param.getJSONArray("members");
        List<String> membersList = new ArrayList<>();
        for (int i = 0; i < members.length(); i++) {
            membersList.add((String) members.get(i));
        }

        asyncRunnable(() -> {
            try {
                EMChatRoom room = EMClient.getInstance().chatroomManager().removeChatRoomMembers(roomId, membersList);
                onSuccess(result, channelName, ChatRoomHelper.toJson(room));
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void blockChatRoomMembers(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        JSONArray blockMembers = param.getJSONArray("members");
        List<String> blockMembersList = new ArrayList<>();
        for (int i = 0; i < blockMembers.length(); i++) {
            blockMembersList.add((String) blockMembers.get(i));
        }

        asyncRunnable(() -> {
            try {
                EMChatRoom room = EMClient.getInstance().chatroomManager().blockChatroomMembers(roomId,
                        blockMembersList);
                onSuccess(result, channelName, ChatRoomHelper.toJson(room));
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void unBlockChatRoomMembers(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        JSONArray blockMembers = param.getJSONArray("members");
        List<String> blockMembersList = new ArrayList<>();
        for (int i = 0; i < blockMembers.length(); i++) {
            blockMembersList.add((String) blockMembers.get(i));
        }

        asyncRunnable(() -> {
            try {
                EMChatRoom room = EMClient.getInstance().chatroomManager().unblockChatRoomMembers(roomId,
                        blockMembersList);
                onSuccess(result, channelName, ChatRoomHelper.toJson(room));
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void fetchChatRoomBlockList(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        int pageNum = param.getInt("pageNum");
        int pageSize = param.getInt("pageSize");

        asyncRunnable(() -> {
            try {
                List<String> blockList = EMClient.getInstance().chatroomManager().fetchChatRoomBlackList(roomId,
                        pageNum, pageSize);
                onSuccess(result, channelName, blockList);
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void updateChatRoomAnnouncement(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");
        String announcement = param.getString("announcement");

        asyncRunnable(() -> {
            try {
                EMClient.getInstance().chatroomManager().updateChatRoomAnnouncement(roomId, announcement);
                onSuccess(result, channelName, true);
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void fetchChatRoomAnnouncement(JSONObject param, String channelName, MethodChannel.Result result)
            throws JSONException {
        String roomId = param.getString("roomId");

        asyncRunnable(() -> {
            try {
                String announcement = EMClient.getInstance().chatroomManager().fetchChatRoomAnnouncement(roomId);
                onSuccess(result, channelName, announcement);
            } catch (HyphenateException e) {
                onError(result, e);
            }
        });
    }

    private void addMembersToChatRoomWhiteList(JSONObject param, String channelName, MethodChannel.Result result) throws JSONException {
        String roomId = param.getString("roomId");
        JSONArray jsonAry = param.getJSONArray("members");
        List<String> members = new ArrayList<>();
        for (int i = 0; i < jsonAry.length(); i++) {
            members.add((String) jsonAry.get(i));
        }
        EMValueWrapperCallBack<EMChatRoom> callBack = new EMValueWrapperCallBack<EMChatRoom>(
                result, channelName) {
            @Override
            public void onSuccess(EMChatRoom object) {
                updateObject(null);
            }
        };

        EMClient.getInstance().chatroomManager().addToChatRoomWhiteList(roomId, members, callBack);

    }

    private void removeMembersFromChatRoomWhiteList(JSONObject param, String channelName, MethodChannel.Result result) throws JSONException {
        String roomId = param.getString("roomId");
        JSONArray jsonAry = param.getJSONArray("members");
        List<String> members = new ArrayList<>();
        for (int i = 0; i < jsonAry.length(); i++) {
            members.add((String) jsonAry.get(i));
        }
        EMValueWrapperCallBack<EMChatRoom> callBack = new EMValueWrapperCallBack<EMChatRoom>(
                result, channelName) {
            @Override
            public void onSuccess(EMChatRoom object) {
                updateObject(null);
            }
        };

        EMClient.getInstance().chatroomManager().removeFromChatRoomWhiteList(roomId, members, callBack);
    }

    private void isMemberInChatRoomWhiteListFromServer(JSONObject param, String channelName, MethodChannel.Result result) throws JSONException {
        String roomId = param.getString("roomId");
        EMClient.getInstance().chatroomManager().checkIfInChatRoomWhiteList(roomId, new EMValueWrapperCallBack<Boolean>(result, channelName));
    }

    private void fetchChatRoomWhiteListFromServer(JSONObject param, String channelName, MethodChannel.Result result) throws JSONException {
        String roomId = param.getString("roomId");
        EMClient.getInstance().chatroomManager().fetchChatRoomWhiteList(roomId, new EMValueWrapperCallBack<List<String>>(result, channelName));
    }

    private void muteAllChatRoomsMembers(JSONObject param, String channelName, MethodChannel.Result result) throws JSONException {
        String roomId = param.getString("roomId");

        EMValueWrapperCallBack<EMChatRoom> callback = new EMValueWrapperCallBack<EMChatRoom>(result, channelName) {
            @Override
            public void onSuccess(EMChatRoom object) {
                updateObject(null);
            }
        };

        EMClient.getInstance().chatroomManager().muteAllMembers(roomId, callback);
    }

    private void unMuteAllChatRoomsMembers(JSONObject param, String channelName, MethodChannel.Result result) throws JSONException {
        String roomId = param.getString("roomId");

        EMValueWrapperCallBack<EMChatRoom> callback = new EMValueWrapperCallBack<EMChatRoom>(result, channelName) {
            @Override
            public void onSuccess(EMChatRoom object) {
                updateObject(null);
            }
        };

        EMClient.getInstance().chatroomManager().unmuteAllMembers(roomId, callback);
    }

    public void fetchChatRoomAttributes(JSONObject param, String channelName, MethodChannel.Result result) throws JSONException {
        String roomId = param.getString("roomId");
        List<String> keys = new ArrayList<>();
        if (param.has("keys")){
            JSONArray array = param.getJSONArray("keys");
            for (int i = 0; i < array.length(); i++) {
                keys.add(array.getString(i));
            }
        }
        EMClient.getInstance().chatroomManager().asyncFetchChatroomAttributesFromServer(roomId, keys, new EMValueWrapperCallBack(result, channelName));
    }

    public void setChatRoomAttributes(JSONObject param, String channelName, MethodChannel.Result result) throws JSONException {
        String roomId = param.getString("roomId");
        Map<String, String> attributes = new HashMap<>();
        if (param.has("attributes")) {
            JSONObject jsonObject = param.getJSONObject("attributes");
            Iterator iterator = jsonObject.keys();
            while (iterator.hasNext()) {
                String key = iterator.next().toString();
                attributes.put(key, jsonObject.getString(key));
            }
        }
        boolean autoDelete = false;
        if (param.has("autoDelete")) {
            autoDelete = param.getBoolean("autoDelete");
        }
        boolean forced = false;
        if(param.has("forced")) {
            forced = param.getBoolean("forced");
        }

        ChatRoomManagerWrapper current = this;

        EMResultCallBack callback = (EMResultCallBack<Map<String, Integer>>) (code, value) -> asyncRunnable(()->{
            if (value.size() > 0 || code == EMError.EM_NO_ERROR) {
                current.onSuccess(result, channelName, value);
            }else {
                HyphenateException e = new HyphenateException(code, "");
                current.onError(result, e);
            }
        });

        if (forced) {
            EMClient.getInstance().chatroomManager().asyncSetChatroomAttributesForced(roomId, attributes, autoDelete, callback);
        }else {
            EMClient.getInstance().chatroomManager().asyncSetChatroomAttributes(roomId, attributes, autoDelete, callback);
        }
    }

    public void removeChatRoomAttributes(JSONObject param, String channelName, MethodChannel.Result result) throws JSONException {
        String roomId = param.getString("roomId");
        List<String> keys = new ArrayList<String>();
        if (param.has("keys")){
            JSONArray array = param.getJSONArray("keys");
            for (int i = 0; i < array.length(); i++) {
                keys.add(array.getString(i));
            }
        }

        boolean forced = false;
        if(param.has("forced")) {
            forced = param.getBoolean("forced");
        }

        ChatRoomManagerWrapper current = this;
        EMResultCallBack callback = (EMResultCallBack<Map<String, Integer>>) (code, value) -> asyncRunnable(()->{
            if (value.size() > 0 || code == EMError.EM_NO_ERROR) {
                current.onSuccess(result, channelName, value);
            }else {
                HyphenateException e = new HyphenateException(code, "");
                current.onError(result, e);
            }
        });
        if (forced){
            EMClient.getInstance().chatroomManager().asyncRemoveChatRoomAttributesFromServerForced(roomId, keys, callback);
        }else {
            EMClient.getInstance().chatroomManager().asyncRemoveChatRoomAttributesFromServer(roomId, keys, callback);
        }
    }

    private void registerEaseListener() {

        if (chatRoomChangeListener != null) {
            EMClient.getInstance().chatroomManager().removeChatRoomListener(chatRoomChangeListener);
        }

        chatRoomChangeListener = new EMChatRoomChangeListener() {

            @Override
            public void onWhiteListAdded(String chatRoomId, List<String> whitelist) {
                ListenerHandle.getInstance().addHandle(
                        ()-> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", chatRoomId);
                            data.put("whitelist", whitelist);
                            data.put("type", "onRoomWhiteListAdded");
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );

            }

            @Override
            public void onWhiteListRemoved(String chatRoomId, List<String> whitelist) {
                ListenerHandle.getInstance().addHandle(
                        ()-> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", chatRoomId);
                            data.put("whitelist", whitelist);
                            data.put("type", "onRoomWhiteListRemoved");
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );
            }

            @Override
            public void onAllMemberMuteStateChanged(String chatRoomId, boolean isMuted) {
                ListenerHandle.getInstance().addHandle(
                        ()-> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", chatRoomId);
                            data.put("isMuted", isMuted);
                            data.put("type", "onRoomAllMemberMuteStateChanged");
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );

            }

            @Override
            public void onChatRoomDestroyed(String roomId, String roomName) {
                ListenerHandle.getInstance().addHandle(
                        ()-> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", roomId);
                            data.put("roomName", roomName);
                            data.put("type", "onRoomDestroyed");
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );

            }


            public void onMemberJoined(String roomId, String participant, String ext) {
                ListenerHandle.getInstance().addHandle(
                        () -> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", roomId);
                            data.put("participant", participant);
                            data.put("type", "onRoomMemberJoined");
                            if(ext != null) {
                                data.put("ext", ext);
                            }
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );
            }

            @Override
            public void onMemberExited(String roomId, String roomName, String participant) {
                ListenerHandle.getInstance().addHandle(
                        ()-> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", roomId);
                            data.put("roomName", roomName);
                            data.put("participant", participant);
                            data.put("type", "onRoomMemberExited");
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );

            }

            @Override
            public void onRemovedFromChatRoom(int reason, String roomId, String roomName, String participant) {
                ListenerHandle.getInstance().addHandle(
                        ()-> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", roomId);
                            data.put("roomName", roomName);
                            data.put("participant", participant);
                            data.put("type", "onRoomRemoved");
                            data.put("reason", reason);
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );

            }

            @Override
            public void onMuteListAdded(String s, List<String> list, long l) {

            }

//            @Override
//            public void onMuteListAdded(String chatRoomId, List<String> mutes, long expireTime) {
//                EMListenerHandle.getInstance().addHandle(
//                        ()-> {
//                            Map<String, Object> data = new HashMap<>();
//                            data.put("roomId", chatRoomId);
//                            data.put("mutes", mutes);
//                            data.put("expireTime", String.valueOf(expireTime));
//                            data.put("type", "onRoomMuteListAdded");
//                            post(() -> channel.invokeMethod(EMSDKMethod.chatRoomChange, data));
//                        }
//                );
//            }

            @Override
            public void onMuteListAdded(String chatRoomId, Map<String,Long> muteInfo) {
                ListenerHandle.getInstance().addHandle(
                        ()-> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", chatRoomId);
                            data.put("mutes", muteInfo);
                            data.put("type", "onRoomMuteListAdded");
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );
            }

            @Override
            public void onMuteListRemoved(String chatRoomId, List<String> mutes) {
                ListenerHandle.getInstance().addHandle(
                        ()-> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", chatRoomId);
                            data.put("mutes", mutes);
                            data.put("type", "onRoomMuteListRemoved");
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );

            }

            @Override
            public void onAdminAdded(String chatRoomId, String admin) {
                ListenerHandle.getInstance().addHandle(
                        ()-> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", chatRoomId);
                            data.put("admin", admin);
                            data.put("type", "onRoomAdminAdded");
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );

            }

            @Override
            public void onAdminRemoved(String chatRoomId, String admin) {
                ListenerHandle.getInstance().addHandle(
                        ()-> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", chatRoomId);
                            data.put("admin", admin);
                            data.put("type", "onRoomAdminRemoved");
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );
            }

            @Override
            public void onOwnerChanged(String chatRoomId, String newOwner, String oldOwner) {
                ListenerHandle.getInstance().addHandle(
                        ()-> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", chatRoomId);
                            data.put("newOwner", newOwner);
                            data.put("oldOwner", oldOwner);
                            data.put("type", "onRoomOwnerChanged");
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );

            }

            @Override
            public void onAnnouncementChanged(String chatRoomId, String announcement) {
                ListenerHandle.getInstance().addHandle(
                        ()-> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", chatRoomId);
                            data.put("announcement", announcement);
                            data.put("type", "onRoomAnnouncementChanged");
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );
            }

            @Override
            public void onSpecificationChanged(EMChatRoom room) {
                ListenerHandle.getInstance().addHandle(
                        ()-> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("room", ChatRoomHelper.toJson(room));
                            data.put("type", "onRoomSpecificationChanged");
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );
            }

            @Override
            public void onAttributesUpdate(String chatRoomId, Map<String, String> attributeMap, String from) {
                ListenerHandle.getInstance().addHandle(
                        ()-> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", chatRoomId);
                            data.put("type", "onRoomAttributesDidUpdated");
                            data.put("attributes", attributeMap);
                            data.put("fromId", from);
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );
            }

            @Override
            public void onAttributesRemoved(String chatRoomId, List<String> keyList, String from) {
                ListenerHandle.getInstance().addHandle(
                        () -> {
                            Map<String, Object> data = new HashMap<>();
                            data.put("roomId", chatRoomId);
                            data.put("keys", keyList);
                            data.put("type", "onRoomAttributesDidRemoved");
                            data.put("fromId", from);
                            post(() -> channel.invokeMethod(MethodKey.chatRoomChange, data));
                        }
                );
            }
        };

        EMClient.getInstance().chatroomManager().addChatRoomChangeListener(chatRoomChangeListener);
    }

    @Override
    public void unRegisterEaseListener() {
        EMClient.getInstance().chatroomManager().removeChatRoomListener(chatRoomChangeListener);
    }

    // 4.12.1
    private void isMemberInChatRoomMuteList(JSONObject param, String channelName, MethodChannel.Result result) throws JSONException{
        String groupId = param.getString("roomId");
        EMClient.getInstance().chatroomManager().asyncCheckIfInMuteList(groupId, new EMValueWrapperCallBack<Boolean>(result, channelName) {
            @Override
            public void onSuccess(Boolean object) {
                updateObject(object);
            }
        });
    }
}
