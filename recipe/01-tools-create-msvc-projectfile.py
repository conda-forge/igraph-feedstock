diff --git a/tools/create-msvc-projectfile.py b/tools/create-msvc-projectfile.py
index a08758e..0c6f5eb 100755
--- a/tools/create-msvc-projectfile.py
+++ b/tools/create-msvc-projectfile.py
@@ -43,6 +43,7 @@ def runmake(makefile, target):
     out = check_output("make -q -C " + os.path.dirname(makefile) + 
                        " -f " + os.path.basename(makefile) + 
                        " " + target, shell=True)
+    out = out.decode("utf-8")
     return out.replace("/", "\\")
 
 def rreplace(s, old, new, occurrence):
@@ -51,7 +52,7 @@ def rreplace(s, old, new, occurrence):
 
 def main():
     if len(sys.argv) != 4:
-        print "Error: need three arguments"
+        print("Error: need three arguments")
         sys.exit(1)
     package = sys.argv[1]
     projectfile = sys.argv[2]
