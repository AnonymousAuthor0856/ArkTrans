// src/main/ets/CouponPacken.ets

import { canvas } from '@kit.ArkGraphics';

@Entry
@Component
struct CouponPacken {
  @State coupons: Coupon[] = [
    { id: 1, title: "Grocery Pack", value: "-$5", colorA: "#7B61FF", colorB: "#26C6DA" },
    { id: 2, title: "Cafe Bundle", value: "-15%", colorA: "#26C6DA", colorB: "#FF8A80" },
    { id: 3, title: "Electro Deal", value: "-$20", colorA: "#FF8A80", colorB: "#7B61FF" },
    { id: 4, title: "Fashion Duo", value: "-10%", colorA: "#26C6DA", colorB: "#7B61FF" }
  ]

  build() {
    // === Column (Root) ===
    // props: { space: 16 }
    // modifier: { width: '100%', height: '100%', padding: 16, linearGradient: { angle: 90, colors: [[ '#26C6DA', 0.25 ], [ '#F5F7FF', 0.5 ], [ '#7B61FF', 0.25 ]] } }
    // children: 6
    Column() {
      // === Row (Header) ===
      // props: { space: 16 }
      // modifier: { width: '100%', justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }
      // children: 3
      Row() {
        // === Image ===
        // modifier: { width: 20, height: 20, backgroundColor: '#0B1220' }
        Image($r('app.media.startIcon')).width(20).height(20).backgroundColor('#0B1220')

        // === Text ===
        // props: { text: 'Coupon Pack' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#0B1220' }
        Text('Coupon Pack').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#0B1220')

        // === Image ===
        // modifier: { width: 20, height: 20, backgroundColor: '#7B61FF' }
        Image($r('app.media.startIcon')).width(20).height(20).backgroundColor('#7B61FF')
      }

      // === Text ===
      // props: { text: 'Nearby Packs' }
      // modifier: { fontSize: 20, fontWeight: FontWeight.SemiBold, color: '#0B1220' }
      Text('Nearby Packs').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#0B1220')

      // === Stack (Map Container) ===
      // props: { alignContent: Alignment.TopStart }
      // modifier: { width: '100%', aspectRatio: 16 / 9, backgroundColor: '#FFF', borderRadius: 20, padding: 12 }
      // children: 2
      Stack({ alignContent: Alignment.TopStart }) {
        // === Canvas (Map Background & Pins) ===
        // modifier: { width: '100%', height: '100%' }
        Canvas()
          .onReady((context: canvas.CanvasRenderingContext2D) => {
            context.fillStyle = '#F0F2F8';
            context.fillRect(0, 0, 1000, 1000);

            context.fillStyle = '#7B61FF';
            context.beginPath();
            context.arc(200, 300, 14, 0, 2 * Math.PI);
            context.fill();

            context.fillStyle = '#26C6DA';
            context.beginPath();
            context.arc(600, 400, 14, 0, 2 * Math.PI);
            context.fill();

            context.fillStyle = '#FF8A80';
            context.beginPath();
            context.arc(800, 350, 14, 0, 2 * Math.PI);
            context.fill();
          })
          .width('100%')
          .height('100%')

        // === Row (Legend) ===
        // props: { space: 8 }
        // modifier: { margin: 12, padding: { left: 12, right: 12, top: 4, bottom: 4 }, backgroundColor: '#FFFFFF', opacity: 0.9, borderRadius: 8, alignItems: ItemAlign.Center }
        // children: 6
        Row({ space: 8 }) {
          // === Image ===
          // modifier: { width: 10, height: 10, backgroundColor: '#7B61FF' }
          Image($r('app.media.startIcon')).width(10).height(10).backgroundColor('#7B61FF')
          // === Text ===
          // props: { text: 'A' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#0B1220' }
          Text('A').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220')
          // === Image ===
          // modifier: { width: 10, height: 10, backgroundColor: '#26C6DA' }
          Image($r('app.media.startIcon')).width(10).height(10).backgroundColor('#26C6DA')
          // === Text ===
          // props: { text: 'B' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#0B1220' }
          Text('B').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220')
          // === Image ===
          // modifier: { width: 10, height: 10, backgroundColor: '#FF8A80' }
          Image($r('app.media.startIcon')).width(10).height(10).backgroundColor('#FF8A80')
          // === Text ===
          // props: { text: 'C' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#0B1220' }
          Text('C').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220')
        }.margin(12).padding({ left: 12, right: 12, top: 4, bottom: 4 }).backgroundColor('#FFFFFF').opacity(0.9).borderRadius(8).alignItems(VerticalAlign.Center)
      }.width('100%').aspectRatio(16 / 9).backgroundColor('#FFF').borderRadius(20).padding(12)

      // === Text ===
      // props: { text: 'Your Coupon Packs' }
      // modifier: { fontSize: 20, fontWeight: FontWeight.SemiBold, color: '#0B1220' }
      Text('Your Coupon Packs').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#0B1220')

      // === List (Horizontal Scroll) ===
      // props: { space: 16 }
      // modifier: { width: '100%' }
      // children: 4
      List({ space: 16 }) {
        ForEach(this.coupons, (item: Coupon) => {
          ListItem() {
            // === Column (Card Content) ===
            // props: { space: 8 }
            // modifier: { width: 200, height: 140, padding: 16, backgroundColor: '#FFF', borderRadius: 20, shadow: { radius: 10, color: '#29000000', offsetY: 6 }, linearGradient: { angle: 0, colors: [[ item.colorA, 0.18 ], [ item.colorB, 0.18 ]] } }
            // children: 3
            Column({ space: 8 }) {
              // === Row (Title) ===
              // props: { space: 8 }
              // modifier: { alignItems: ItemAlign.Center }
              // children: 2
              Row({ space: 8 }) {
                // === Image ===
                // modifier: { width: 14, height: 14, backgroundColor: '#7B61FF' }
                Image($r('app.media.startIcon')).width(14).height(14).backgroundColor('#7B61FF')
                // === Text ===
                // props: { text: item.title }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#0B1220' }
                Text(item.title).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
              }.alignItems(VerticalAlign.Center)

              // === Text ===
              // props: { text: item.value }
              // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#0B1220' }
              Text(item.value).fontSize(28).fontWeight(FontWeight.Bold).fontColor('#0B1220')

              // === Button ===
              // props: { type: ButtonType.Capsule }
              // modifier: { width: '100%', height: 40, backgroundColor: '#7B61FF', fontColor: '#FFF', borderRadius: 14 }
              // children: 1
              Button({ type: ButtonType.Capsule }) {
                // === Text ===
                // props: { text: 'Redeem' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#FFF' }
                Text('Redeem').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#FFF')
              }.width('100%').height(40).backgroundColor('#7B61FF').fontColor('#FFF').borderRadius(14)
            }.width(200).height(140).padding(16).backgroundColor('#FFF').borderRadius(20).shadow({ radius: 10, color: '#29000000', offsetY: 6 }).linearGradient({ angle: 0, colors: [[ item.colorA, 0.18 ], [ item.colorB, 0.18 ]] })
          }
        })
      }.width('100%')

      // === Blank ===
      Blank()

      // === Row (Bottom Buttons) ===
      // props: { space: 12 }
      // modifier: { width: '100%' }
      // children: 2
      Row({ space: 12 }) {
        // === Button ===
        // props: { type: ButtonType.Capsule }
        // modifier: { layoutWeight: 1, height: 52, backgroundColor: '#26C6DA', fontColor: '#0B1220', borderRadius: 20 }
        // children: 1
        Button({ type: ButtonType.Capsule }) {
          // === Text ===
          // props: { text: 'My Coupons' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#0B1220' }
          Text('My Coupons').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
        }.layoutWeight(1).height(52).backgroundColor('#26C6DA').fontColor('#0B1220').borderRadius(20)

        // === Button ===
        // props: { type: ButtonType.Capsule }
        // modifier: { layoutWeight: 1, height: 52, backgroundColor: '#7B61FF', fontColor: '#FFF', borderRadius: 20 }
        // children: 1
        Button({ type: ButtonType.Capsule }) {
          // === Text ===
          // props: { text: 'Explore More' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#FFF' }
          Text('Explore More').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFF')
        }.layoutWeight(1).height(52).backgroundColor('#7B61FF').fontColor('#FFF').borderRadius(20)
      }.width('100%')
    }.width('100%').height('100%').padding(16).linearGradient({ angle: 90, colors: [[ '#26C6DA', 0.25 ], [ '#F5F7FF', 0.5 ], [ '#7B61FF', 0.25 ]] })
  }
}

interface Coupon {
  id: number;
  title: string;
  value: string;
  colorA: string;
  colorB: string;
}