
import com.elikv.recommendsystem.RecommendSystemApplication;
import com.elikv.recommendsystem.model.BaiduMapLocation;
import com.elikv.recommendsystem.model.ServiceResult;
import com.elikv.recommendsystem.service.AddressServiceImpl;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.IOException;
import java.lang.reflect.Field;
import java.util.*;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = RecommendSystemApplication.class)
public class YoaWebApplicationTests {

    @Autowired
    public AddressServiceImpl addressService;

    @Test
    public  void test()throws IOException{
        ServiceResult<BaiduMapLocation> location = addressService.getBaiduMapLocation("上海", "中山南二路699号正大乐城3区3层301");
        System.out.println(location);
    }





}
