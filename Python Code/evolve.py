from Tkinter import *
import numpy as np

app = Tk()
app.title("Evolve")

#behaviours and features, each behaviour has an action and a trigger

enviroment = []
def enviInRangeFromItem(rng,me):
    if rng == 0:
        return []
    else:
        wantedEnvi = []
        rngSqrd = rng * rng
        x = me.pos.x
        y = me.pos.y
        for item in enviroment:
            if ((x-item.pos.x)**2 + (y-item.pos.y)**2) <= rng:
                wantedEnvi.append(item)

        return wantedEnvi

class Position:
    def __init__(self,x,y):
        self.x = x
        self.y = y

class FeatureType:
    def __init__(self,featureIndex):
        if featureIndex == 0:
            self.name = "VisibleLight"
            self.effectiveRange = 500 #units
        else if featureIndex == 1:
            self.name = "Sound"
            self.effectiveRange = 150 #units
        else if featureIndex == 2:
            self.name = "Infared"
            self.effectiveRange = 50 #units
        else if featureIndex == 3:
            self.name = "Scent"
            self.effectiveRange = 75 #units
        else if featureIndex == 4:
            self.name = "Touch/Taste"
            self.effectiveRange = 5 #units        
    

class Feature:
    def __init__(self,value,featureIndex):
        self._value = value
        self._featureType = FeatureType(featureIndex)

class Action:
    def __init__(self,action_s,enviRadius):
        self.action_s = action_s
        self.enviRadius=enviRadius

    def do(self,me,envi):
        if type(self.action_s) == list:
            for action in self.action_s:
                action.do(me,enviInRangeFromItem(action.enviRadius,me))
        else:
            self.action_s(me,enviInRangeFromItem(self.enviRadius,me))


class Trigger:
    def __init__(self,condition_s,enviRadius):
        self.condition_s = condition_s
        self.enviRadius = enviRadius

    def test(self,me,envi):
        if type(self.condition_s) == list:
            for condition in self.condition_s:
                if !condition.test(me,enviInRangeFromItem(action.enviRadius,me)):
                    return False

            return True
                
        else:
            return self.condition_s(me,enviInRangeFromItem(self.enviRadius,me))


class Behaviour:
    def __init__(self,trigger,action):
        self.trigger = trigger
        self.action = action

    def perform(self,me):
        if self.trigger.test(me,enviInRangeFromItem(self.trigger.enviRadius,me)):
            self.action.do(me,enviInRangeFromItem(self.action.enviRadius,me))


class Lifeform:
    def __init__(self,features,behaviours)
            
app.mainloop()
