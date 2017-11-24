//alertController使用教程，demo，防止太久没写忘记，不至于google，baidu

#import <Foundation/Foundation.h>

@interface NormalAlertControllDemo : NSObject

@end

//////////////////////////////////====Alert01: 【就是简单的2个按钮】====//////////////////////////////////
//UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"测试" message:@"我说什么好呢" preferredStyle:UIAlertControllerStyleAlert];
//UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    NSLog(@"点击了确定");
//}];
//UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//    NSLog(@"点击了取消");
//}];
//[alert addAction:confirmAction];
//[alert addAction:cancleAction];
//[self presentViewController:alert animated:YES completion:nil];

//////////////////////////////////====Alert02: 【简单2个按钮，加上2个textfiled】====//////////////////////////////////
//UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"测试" message:@"我说什么好呢" preferredStyle:UIAlertControllerStyleAlert];
//UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    NSLog(@"点击了确定");
//}];
//UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//    NSLog(@"点击了取消");
//}];
//[alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//    textField.placeholder = @"输入点什么";
//}];
//[alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//    textField.placeholder = @"还是说点什么吧";
//}];
//[alert addAction:confirmAction];
//[alert addAction:cancleAction];
//[self presentViewController:alert animated:YES completion:nil];

//////////////////////////////////====AlertSheet01: 【下方的alert sheet】====//////////////////////////////////
//UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"f" message:@"f" preferredStyle:UIAlertControllerStyleActionSheet];
//UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    NSLog(@"点击了确定");
//}];
//UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//    NSLog(@"点击了取消");
//}];
//[alert addAction:confirmAction];
//[alert addAction:cancleAction];
//[self presentViewController:alert animated:YES completion:nil];

