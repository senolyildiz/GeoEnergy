public class Math {
    public class FlowInputs{
        @InvocableVariable public integer a;
        @InvocableVariable public integer b;
    }
    
    public class FlowOutputs{
        @InvocableVariable public integer Carpim;
        @InvocableVariable public integer Toplama;
        @InvocableVariable public integer Cikarma;
    }
    
	@InvocableMethod(Label='MathOperation')
    public static list<FlowOutputs> mathOperation(list<FlowInputs>yildiz){
        if (yildiz == null || yildiz.isEmpty()) {
        // Handle null or empty input gracefully, such as returning an empty list
        return new List<FlowOutputs>();
    }
        system.debug(yildiz);
        List<FlowOutputs>Hesaplama= new List <FlowOutputs>();
        FlowOutputs hesap= new FlowOutputs();
        hesap.carpim=yildiz[0].a*yildiz[0].b;
        hesap.toplama=yildiz[0].a+yildiz[0].b;
        hesap.cikarma=yildiz[0].a-yildiz[0].b;
        Hesaplama.add(hesap);
        return Hesaplama;
        
        
        
    }
    
}