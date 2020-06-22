import math
import os
import re
import sys
import subprocess
import time

class Build:
    def __init__(self, system, platform):
        self.System = system
        self.Platform = platform

class Arg:
    def __init__(self, arg, value):
        self.Arg = arg
        self.Value = value

    def ToString(self):
        return "{} {}".format(self.Arg, self.Value)

class VirtualBrain:
    def __init__(self):
        #render scale
        self.RenderScaleValue = 1.75 #lower this if framerate is low
        #folders to use
        self.BuildsFolder = r"VB_Builds"
        self.LocalOutputDataFolder = os.path.join(os.getcwd(), r"VB_Builds\experiment_data")
        self.NetworkOutputDataFolder = os.path.join(os.getcwd(), r"V:\Schloss-VirtualBrain\experiment_data")
        #platforms
        self.PC = 0
        self.OCULUS = 1
        self.PlatformNames = {
            self.PC     : "PC",
            self.OCULUS : "Oculus"
        }
        #systems
        self.PRACTICE = 0
        self.VISUAL = 1
        self.AUDITORY = 2
        self.SystemNames = {
            self.PRACTICE   : "Practice",
            self.VISUAL     : "Visual",
            self.AUDITORY   : "Auditory"
        }
        #build exe locations
        self.BuildExe = "UW Virtual Brain.exe" #name of build exe (should be the same for every build)
        self.PracticeRoom = { #names of folders (each build has its own folder)
            self.PC     : "PCPractice",
            self.OCULUS : "OculusPractice"
        }
        self.VisualSystem = {
            self.PC     : "PCVisual",
            self.OCULUS : "OculusVisual"
        }
        self.AuditorySystem = {
            self.PC     : "PCAuditory",
            self.OCULUS : "OculusAuditory"
        }
        self.System = {
            self.PRACTICE   : self.PracticeRoom,
            self.VISUAL     : self.VisualSystem,
            self.AUDITORY   : self.AuditorySystem
        }
        #experiment orders
        self.Orders = [
            [Build(self.VISUAL, self.PC), Build(self.AUDITORY, self.OCULUS)],
            [Build(self.AUDITORY, self.PC), Build(self.VISUAL, self.OCULUS)],
            [Build(self.VISUAL, self.OCULUS), Build(self.AUDITORY, self.PC)],
            [Build(self.AUDITORY, self.OCULUS), Build(self.VISUAL, self.PC)]
        ]
        #default args
        self.RenderScale = Arg(r"-renderScale", self.RenderScaleValue)
        self.PID = Arg(r"-pid", 123456789)
        self.LocalOutputFolder = Arg(r"-localDataFolder", self.LocalOutputDataFolder)
        self.NetworkOutputFolder = Arg(r"-networkDataFolder", self.NetworkOutputDataFolder)
        self.HeadsetDataFile = Arg(r"-headsetFile", r"HeadsetData")
        self.LookDataFile = Arg(r"-lookFile", r"LookData")

    def RunExperiment(self):
        print("UW Virtual Brain Project")
        vb_args = []
        #get pid
        pid = int(raw_input("PID: "))
        pid_arg = Arg(self.PID.Arg, pid)
        #vb_args.append(pid_arg.ToString()) #unused
        subject_code = raw_input("Subject Code: ").rstrip()
        #get render scale
        vb_args.append(self.RenderScale.ToString())
        #determine experiment order
        experiment_order = (pid - 1) % len(self.Orders) #start PIDs from 1, not 0
        for i in range(2):
            current_build = self.Orders[experiment_order][i]
            #run practice room
            self.RunBrain(vb_args, pid, subject_code, self.PRACTICE, current_build.Platform)
            #run brain
            self.RunBrain(vb_args, pid, subject_code, current_build.System, current_build.Platform)
        #done
        print("Experiment finished")

    def RunBrain(self, args, pid, subject_code, system, platform):
        #copy initial args into a new list
        brain_args = list(args)
        #get output folders
        brain_args.append(self.LocalOutputFolder.ToString())
        brain_args.append(self.NetworkOutputFolder.ToString())
        #get output filenames
        brain_file_format = "csv"
        headset_data_filename = self.ConstructOutputFilename(pid, subject_code, self.HeadsetDataFile.Value, system, platform, brain_file_format)
        headset_data_filename_arg = Arg(self.HeadsetDataFile.Arg, headset_data_filename)
        brain_args.append(headset_data_filename_arg.ToString())
        look_data_filename = self.ConstructOutputFilename(pid, subject_code, self.LookDataFile.Value, system, platform, brain_file_format)
        look_data_filename_arg = Arg(self.LookDataFile.Arg, look_data_filename)
        brain_args.append(look_data_filename_arg.ToString())
        #get build path
        build_exe = os.path.join(self.System[system][platform], self.BuildExe)
        build_path = os.path.join(self.BuildsFolder, build_exe)
        brain_args.insert(0, build_path)
        #run build
        #print(brain_args)
        raw_input("Press Enter to start {} {}".format(self.PlatformNames[platform], self.SystemNames[system]))
        #print("\tRunning {}".format(brain_args[0]))
        brain_process = subprocess.Popen(' '.join(brain_args))
        brain_process.wait()
        #raw_input("Press Enter to continue experiment")

    def ConstructOutputFilename(self, pid, subject_code, default_filename, system, platform, file_format):
        system_name = self.SystemNames[system]
        platform_name = self.PlatformNames[platform]
        output_filename = "_".join([str(pid), str(subject_code), default_filename, system_name, platform_name])
        output_filename = ".".join([output_filename, file_format])
        return output_filename

if __name__ == '__main__':
    vb = VirtualBrain()
    vb.RunExperiment()