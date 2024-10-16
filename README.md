# MW208 Raceline Optimization
<Desc of proj>
  
### **Concept**

My main idea consisted of two parts: first, create a minimum curvature trajectory and then develop a velocity profile based around it. This method is generally used by almost every paper written on this topic, at least as a starting point. I also calculated the velocity profile of the shortest path around the given track to show how bad the lap times are for it compared to the min curvature one. I also validated most of my results with data and literature I found online.

### **Trajectory Generation**

For this section, I followed a global approach for both the shortest path and min curvature trajectory. The methodology I stuck to is outlined in this paper, [Race Driver Model](https://dl.acm.org/doi/10.1016/j.compstruc.2007.04.028). 

I converted this entire subject into a quadratic programming (QP) problem and solved it with the help of the '[quadprog](https://in.mathworks.com/help/optim/ug/quadprog.html)' function in MATLAB. I also derived the equations for H and B matrices myself in terms of the coordinates of the track edges. Then I substituted these matrices in the QP solver along with the constraints that restrict the trajectory within the boundaries. I also added another condition that requires the starting point to be the same as the end one. The reasoning behind this was to create a loop rather than a broken track at the end. 

As soon as the solver is executed, it automatically outputs the results, making the solving time almost negligible. It usually takes around 11-12 iterations to find the result. Unfortunately, quadprog doesn't have the functionality to output the result of every iteration, making me incapable of rendering the really cool animated GIFs.

Some of the drawbacks and improvements to my method have been mentioned in this paper [Minimum curvature trajectory planning and control for an autonomous race car](https://www.tandfonline.com/doi/abs/10.1080/00423114.2019.1631455?journalCode=nvsd20). One critical simplifying assumption I made was neglecting the 2x'y' term in my curvature definition. This leads to a slightly suboptimal solution but significantly reduces the effort for calculating the H and B matrices. One improvement would be to use an iterative QP routine that replaces the reference line with the solution of the previous QP iteration.
  
Shortest Path Trajectory |  Minimum Curvature Trajectory 
:-------------------------:|:-------------------------:
<img src="https://user-images.githubusercontent.com/58664908/128596618-575a2a3c-70fd-49e1-820d-698fe9b1d8b0.png" width=100% height=100%>|<img src="https://user-images.githubusercontent.com/58664908/128598833-c99c9c31-b9b9-4988-aa61-ef6dd28a60c9.png" width=100% height=100%>

For comparison - [Raceline uploaded by TUMFTM for Silverstone track](https://user-images.githubusercontent.com/58664908/128598878-c3997de2-ea97-4d82-a775-bd9cfa0a177a.png)

Any feedback or suggestions are welcome!
