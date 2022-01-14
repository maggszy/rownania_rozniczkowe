module skocznia

using Plots

#instrukcja importowania ---> wpisz w komórce: include("skocznia.jl")

function draw_trackk(h,czas,t1,dt,angle=30) 
    """
    Funkcja rysująca samą skocznie
    :param h: wysokość skoczni
    :param angle: kąt nachylenia skoczni
    
    """
    angle_slope = angle/180 * π
    distance_max = h * 2
    length_slope = h / tan(angle_slope)
    y(x)=-tan(angle_slope)*x+h
    
    axis_x = [0,distance_max] 
    axis_y = [0,distance_max]
    
    #for equation
    track_x = [i for i in (1 : floor(Int, (czas+t1) / dt))] 
    track_x[1] = 0
    track_y = [y(i) for i in (1 : floor(Int, (czas+t1) / dt))] 

    
    return track_x,track_y,axis_x,axis_y,length_slope
end

function plot_with_skijump(h,angle,czas,t1,dt,zasieg_opor,hₘ_opor,func_x,func_y,cross,lbl)
    """
    Funkcja plotuje tor ruchu skoczka naraciarskiego na skoczni
    :param h: wysokość skoczni
    :param angle: kąt nachylenia skoczni
    :param func_x: talica z danymi toru ruchu dla wsp x
    :pram func_y: talica z danymi toru ruchu dla wsp y
    :pram cross: pkt przecięcia się toru ruchu ze skocznią (dla wsp x)
    :param lbl: tytuł dla etykiety funkcji
    """
    track_x,track_y,axis_x,axis_y,length_slope=draw_trackk(h,czas,t1,dt,angle)
    x,y = func_x,func_y
    
    for i in 1:length(x)
        if x[i] >= cross
            for j in i:length(x)
                y[j] = track_y[j]
                x[j] = track_x[j]
            end
        end
    end

    plot(x, y, 
        xlabel = "odległość [m]", 
        ylabel = "wysokość [m]",
        label = lbl,
        xlim = (0, zasieg_opor),
        ylim = (0, hₘ_opor),
        legend = :bottom,
        linewidth = 4.5,
        linecolor="#6495ED",
        title = "tor ruchu")
    
    plot!(track_x,track_y,
        label = "",
        linecolor="#708090")
    plot!(axis_x,axis_y, 
        seriestype=:scatter,
        label = "",
        xlim = (axis_x[1],axis_x[2]),
        ylim = (axis_y[1],axis_y[2]))
end

function plot_with_skijump2(h,angle,czas,t1,dt,zasieg_opor,hₘ_opor,func_x,func_y,cross1,lbl,func_x2,func_y2,cross2,lbl2) 
    """
    Funkcja plotuje dwa tory ruchu skoczka naraciarskiego na skoczni
    :param h: wysokość skoczni
    :param angle: kąt nachylenia skoczni
    :param func_x: talica z danymi toru ruchu dla wsp x
    :pram func_y: talica z danymi toru ruchu dla wsp y
    :pram cross1: pkt przecięcia się toru ruchu ze skocznią (dla wsp x)
    :param lbl1: tytuł dla etykiety funkcji
    :param func_x: talica z danymi drugiego toru ruchu dla wsp x
    :pram func_y: talica z danymi drugiego toru ruchu dla wsp y
    :pram cross2: pkt przecięcia się drugiego toru ruchu ze skocznią (dla wsp x)
    :param lbl1: tytuł dla etykiety drugiej funkcji
    """
    track_x,track_y,axis_x,axis_y,length_slope=draw_trackk(h,czas,t1,dt,angle)
    x,y = func_x,func_y
    x2,y2= func_x2,func_y2
    
    for i in 1:length(x)
        if x[i] >= cross1
            for j in i:length(x)
                y[j] = track_y[j]
                x[j] = track_x[j]
            end
        end
    end
    
    for i in 1:length(x2)
        if x2[i] >= cross2
            for j in i:length(x2)
                y2[j] = track_y[j]
                x2[j] = track_x[j]
            end
        end
    end

    plot(x, y, 
        xlabel = "odległość [m]", 
        ylabel = "wysokość [m]",
        label = lbl,
        xlim = (0, zasieg_opor),
        ylim = (0, hₘ_opor),
        legend = :bottom,
        linewidth = 2.5,
        linecolor="#6495ED",
        title = "tor ruchu")
    
    plot!(x2, y2, 
        xlabel = "odległość [m]", 
        ylabel = "wysokość [m]",
        label = lbl2,
        xlim = (0, zasieg_opor),
        ylim = (0, hₘ_opor),
        legend = :bottom,
        linewidth = 2.5,
        linecolor="#87CEEB",
        title = "tor ruchu")
    
    plot!(track_x,track_y,
        label = "",
        linecolor="#708090")
    plot!(axis_x,axis_y, 
        seriestype=:scatter,
        label = "",
        xlim = (axis_x[1],axis_x[2]),
        ylim = (axis_y[1],axis_y[2]))
end

end