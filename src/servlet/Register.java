package servlet;

public class Register  {
    private float sv;
    private double ds;
    private int name;

    public float getSv() {
        return sv;
    }

    public void setSv(float sv) {
        this.sv = sv;
    }

    public double getDs() {
        return ds;
    }

    public void setDs(double ds) {
        this.ds = ds;
    }

    public int getName() {
        return name;
    }

    public void setName(int name) {
        this.name = name;
    }

    public Register(float sv, double ds, int name) {
        this.sv = sv;
        this.ds = ds;
        this.name = name;
    }
}
