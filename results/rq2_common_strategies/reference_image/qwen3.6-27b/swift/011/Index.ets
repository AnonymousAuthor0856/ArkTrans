// App.ets
import { ForumPostView } from './ForumPostView'

@Entry
@Component
struct ForumPostApp {
  build() {
    Column() {
      ForumPostView()
    }
    .backgroundColor('#101024')
    .width('100%')
    .height('100%')
  }
}

// ForumPostView.ets
@Component
export struct ForumPostView {
  @State voteState: number = 1
  @State commentText: string = ''
  
  private post = {
    author: { name: 'user/compose_master', avatarColor: '#76FF02' },
    timestamp: '8 hours ago',
    title: 'The power of Jetpack Compose for single-file UIs',
    body: 'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
    votes: 1337,
    commentCount: 42
  }
  
  private replies = [
    { id: 1, author: { name: 'dev/android_fan', avatarColor: '#FF00AA' }, timestamp: '7h ago', text: 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', votes: 25 },
    { id: 2, author: { name: 'ux/designer_jane', avatarColor: '#00E5FF' }, timestamp: '5h ago', text: 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', votes: 18 }
  ]
  
  build() {
    Column() {
      TopAppBar()
      
      Scroll() {
        Column() {
          PostCard({ 
            post: this.post, 
            voteState: this.voteState, 
            onVote: (newVote: number) => {
              this.voteState = newVote
            }
          })
          
          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#444466')
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 20, right: 20, top: 10, bottom: 10 })
          
          ForEach(this.replies, (reply: any) => {
            ReplyCard({ reply: reply })
              .padding({ left: 20, right: 20, top: 10, bottom: 10 })
          })
        }
      }
      .backgroundColor('#101024')
      .layoutWeight(1)
      
      BottomCommentBar({ commentText: $commentText })
    }
    .backgroundColor('#101024')
    .width('100%')
    .height('100%')
  }
}

// TopAppBar.ets
@Component
struct TopAppBar {
  build() {
    Row() {
      Button() {
        Image($r('app.media.back_arrow')) // You'll need to add this image resource
          .width(24)
          .height(24)
          .fillColor('#00E5FF')
      }
      .backgroundColor(Color.Transparent)
      .width(50)
      .height(50)
      
      Spacer()
      
      Text('r/jetpackcompose')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#DEE0FF')
      
      Spacer()
      
      Blank()
        .width(50)
        .height(50)
    }
    .width('100%')
    .height(60)
    .padding({ left: 20, right: 20 })
    .backgroundColor('#1C1C39')
  }
}

// PostCard.ets
@Component
struct PostCard {
  post: any
  voteState: number
  onVote: (vote: number) => void
  
  build() {
    Row() {
      // Vote section
      Column() {
        Button() {
          UpVoteArrow({ color: this.voteState === 1 ? '#FF00AA' : '#444466' })
        }
        .backgroundColor(Color.Transparent)
        
        Text(`${this.post.votes + this.voteState - 1}`)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? '#FF00AA' : '#DEE0FF')
        
        Button() {
          UpVoteArrow({ color: this.voteState === -1 ? '#00E5FF' : '#444466' })
            .rotate({ angle: 180 })
        }
        .backgroundColor(Color.Transparent)
      }
      .width(60)
      .justifyContent(FlexAlign.SpaceBetween)
      
      // Content section
      Column() {
        AuthorInfo({ author: this.post.author, timestamp: this.post.timestamp })
        
        Text(this.post.title)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#DEE0FF')
          .width('100%')
          .margin({ top: 10 })
        
        Text(this.post.body)
          .fontSize(18)
          .fontColor('#B3B6D6')
          .width('100%')
          .margin({ top: 10 })
        
        Row() {
          InfoChip({ text: `${this.post.commentCount} Comments` })
          InfoChip({ text: 'Share' })
        }
        .margin({ top: 10 })
      }
      .layoutWeight(1)
    }
    .padding(20)
    .width('100%')
    .backgroundColor('#1C1C39')
  }
}

// ReplyCard.ets
@Component
struct ReplyCard {
  reply: any
  
  build() {
    Row() {
      // Left border
      Column()
        .width(3)
        .borderRadius(1.5)
        .backgroundColor(this.reply.author.avatarColor + '80') // Add opacity
      
      // Content
      Column() {
        AuthorInfo({ author: this.reply.author, timestamp: this.reply.timestamp })
        
        Text(this.reply.text)
          .fontSize(18)
          .fontColor('#C4C7E7')
          .width('100%')
          .margin({ top: 6 })
        
        Row() {
          InfoChip({ text: `${this.reply.votes} votes` })
          InfoChip({ text: 'Reply' })
        }
        .margin({ top: 6 })
      }
      .layoutWeight(1)
      .margin({ left: 16 })
    }
    .width('100%')
  }
}

// AuthorInfo.ets
@Component
struct AuthorInfo {
  author: any
  timestamp: string
  
  build() {
    Row() {
      // Avatar
      Stack() {
        Circle()
          .width(28)
          .height(28)
          .fill(this.author.avatarColor)
        
        Circle()
          .width(10)
          .height(10)
          .fill('#33000000') // Black with 20% opacity
      }
      
      Text(this.author.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)
        .margin({ left: 10 })
      
      Text(this.timestamp)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#444466')
        .margin({ left: 10 })
    }
  }
}

// InfoChip.ets
@Component
struct InfoChip {
  text: string
  
  build() {
    Text(this.text)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor('#444466')
  }
}

// UpVoteArrow.ets
@Component
struct UpVoteArrow {
  color: string
  
  build() {
    CanvasRenderingContext2D()
      .draw((context: CanvasRenderingContext2D, size: Size) => {
        context.beginPath()
        context.moveTo(size.width / 2, 0)
        context.lineTo(size.width, size.height / 2)
        context.lineTo(size.width / 2, size.height)
        context.lineTo(0, size.height / 2)
        context.closePath()
        context.fillStyle = this.color
        context.fill()
      })
      .width(28)
      .height(28)
  }
}

// BottomCommentBar.ets
@Component
struct BottomCommentBar {
  @Link commentText: string
  
  build() {
    Column() {
      Divider()
        .color('#444466')
        .opacity(0.3)
        .margin({ left: 20, right: 20 })
      
      Row() {
        // Input field
        Stack({ alignContent: Alignment.Start }) {
          Capsule()
            .width('100%')
            .height(52)
            .backgroundColor('#28284A')
          
          if (this.commentText === '') {
            Text('Add a comment...')
              .fontSize(18)
              .fontColor('#444466')
              .margin({ left: 20 })
          }
          
          TextInput({ placeholder: '' })
            .type(InputType.Normal)
            .width('100%')
            .height(52)
            .backgroundColor(Color.Transparent)
            .fontSize(18)
            .fontColor('#DEE0FF')
            .margin({ left: 20 })
            .text(this.commentText)
            .onChange((value: string) => {
              this.commentText = value
            })
        }
        .layoutWeight(1)
        
        // Post button
        Button('POST')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .backgroundColor('#00E5FF')
          .borderRadius(20)
          .height(52)
          .margin({ left: 16 })
      }
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor('#1C1C39')
    }
  }
}