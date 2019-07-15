({
    myAction : function(component, event, helper) {
        var action = component.get("c.getAll");
        action.setCallback(this, function(response) {
            console.log(response.getReturnValue());
            component.set('v.orgLimits', response.getReturnValue());
        });
        $A.enqueueAction(action);
    }
})