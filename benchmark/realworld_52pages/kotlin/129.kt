

package com.breens.mpesaappuiclone.preview



import androidx.compose.animation.AnimatedContent
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.togetherWith
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.List
import androidx.compose.material.icons.filled.Notifications
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.filled.Phone
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.filled.Share
import androidx.compose.material.icons.filled.ShoppingCart
import androidx.compose.material.icons.filled.Star
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlinx.coroutines.delay



private val MpesaGreen = Color(0xFF09AF00)
private val ActionBlue = Color(0xFF3722F6)
private val ActionRed = Color(0xFFD32F2F)
private val ActionLightBlue = Color(0xFF2979FF)
private val White = Color(0xFFFFFFFF)
private val Grey = Color(0xFF7A7979)
private val CardGradientPink = Color(0xFFCF4195)
private val CardGradientOrange = Color(0xFFEF6136)
private val CardGradientBlue = Color(0xFF346FDE)
private val CardSolidOrange = Color(0xFFFF6319)
private val CardSolidBlue = Color(0xFF1074FF)
private val CardSolidPink = Color(0xFFB138EB)
private val TranslucentBlack = Color(0x25000000)
private val AvatarBg = Color(0xFFF1F8E9)


private data class PreviewCardInfo(
    val mainTitle: String,
    val mainAmount: String,
    val subTitle: String,
    val subAmount: String,
    val cardLabel: String,   
    val bgIndex: Int 
)

private data class PreviewStatement(
    val initials: String,
    val shopName: String,
    val transactionId: String,
    val amount: String,
    val transactionDate: String
)


private enum class MpesaScreen(val label: String, val icon: ImageVector) {
    Splash("Splash", Icons.Filled.Star),             // unused
    Home("Home", Icons.Filled.Home),
    Transact("Transact", Icons.Filled.List),
    Discover("Discover", Icons.Filled.Search),
    Growth("Growth", Icons.Filled.Star)
}


private fun mockCards(): List<PreviewCardInfo> = listOf(
    PreviewCardInfo(
        mainTitle = "TOTAL SPENT THIS WEEK",
        mainAmount = "KSH. 1,500.00",
        subTitle = "DAILY AVERAGE",
        subAmount = "KSH.845.87",
        cardLabel = "MPESA",
        bgIndex = 0
    ),
    PreviewCardInfo(
        mainTitle = "TOTAL SPENT THIS WEEK",
        mainAmount = "KSH. 1,500.00",
        subTitle = "DAILY AVERAGE",
        subAmount = "KSH.845.87",
        cardLabel = "GENERAL",
        bgIndex = 1
    ),
    PreviewCardInfo(
        mainTitle = "TOTAL SPENT THIS WEEK",
        mainAmount = "KSH. 1,500.00",
        subTitle = "DAILY AVERAGE",
        subAmount = "KSH.845.87",
        cardLabel = "FAMILY",
        bgIndex = 2
    ),
    PreviewCardInfo(
        mainTitle = "TOTAL SPENT THIS WEEK",
        mainAmount = "KSH. 1,500.00",
        subTitle = "DAILY AVERAGE",
        subAmount = "KSH.845.87",
        cardLabel = "BILLS",
        bgIndex = 3
    )
)

private fun mockStatements(): List<PreviewStatement> = listOf(
    PreviewStatement("KS", "GROCERY", "122229393", "Ksh. 2,455.0", "12/01/2022"),
    PreviewStatement("AP", "AIRTIME PURCHASE", "1234", "Ksh. 12.34", "10/06/2022"),
    PreviewStatement("KS", "GROCERY", "122229393", "Ksh. 2,455.0", "12/01/2022"),
    PreviewStatement("AP", "NETFLIX", "1234", "Ksh. -12.34", "10/06/2022"),
    PreviewStatement("KS", "PRIME", "122229393", "Ksh. 2,455.0", "12/01/2022"),
    PreviewStatement("AP", "SHOWMAX", "1234", "Ksh. 12.34", "10/06/2022"),
    PreviewStatement("KS", "TWITCH", "122229393", "Ksh. 2,455.0", "12/01/2022"),
    PreviewStatement("AP", "YOUTUBE", "1234", "Ksh. -12.34", "10/06/2022")
)


@Composable
fun MpesaPreviewApp() {
    var currentScreen by remember { mutableStateOf(MpesaScreen.Splash) }
    var balanceVisible by remember { mutableStateOf(true) }
    var currentCardPage by remember { mutableStateOf(0) }

    LaunchedEffect(Unit) {
        delay(3000)
        currentScreen = MpesaScreen.Home
    }

    MaterialTheme {
        Scaffold(
            bottomBar = {
                if (currentScreen != MpesaScreen.Splash) {
                    BottomNavBar(
                        currentScreen = currentScreen,
                        onScreenChange = { currentScreen = it }
                    )
                }
            }
        ) { innerPadding ->
            AnimatedContent(
                targetState = currentScreen,
                modifier = Modifier.padding(innerPadding),
                transitionSpec = { fadeIn() togetherWith fadeOut() }
            ) { screen ->
                when (screen) {
                    MpesaScreen.Splash -> SplashScreen()
                    MpesaScreen.Home -> HomeScreen(
                        balanceVisible = balanceVisible,
                        onToggleBalance = { balanceVisible = !balanceVisible },
                        currentCardPage = currentCardPage,
                        onCardPageChange = { currentCardPage = it }
                    )
                    else -> PlaceholderScreen(screen)
                }
            }
        }
    }
}



@Composable
private fun SplashScreen() {
    Box(
        modifier = Modifier.fillMaxSize().background(White),
        contentAlignment = Alignment.Center
    ) {
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Text(
                text = "M-PESA",
                fontSize = 28.sp,
                fontWeight = FontWeight.Bold,
                color = MpesaGreen
            )
            Spacer(modifier = Modifier.height(4.dp))
            Text(
                text = "M",
                fontSize = 48.sp,
                fontWeight = FontWeight.ExtraBold,
                color = MpesaGreen
            )
        }
    }
}


@Composable
private fun HomeScreen(
    balanceVisible: Boolean,
    onToggleBalance: () -> Unit,
    currentCardPage: Int,
    onCardPageChange: (Int) -> Unit
) {
    val cards = remember { mockCards() }
    val statements = remember { mockStatements() }

    LazyColumn(
        modifier = Modifier.fillMaxSize().background(White)
    ) {
        item { HomeTopBar() }
        item { BalanceSection(visible = balanceVisible, onToggle = onToggleBalance) }
        item { QuickActionRow() }
        item {
            SpendingCardsPager(
                cards = cards,
                currentPage = currentCardPage,
                onPageChange = onCardPageChange
            )
        }
        item {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 15.dp, vertical = 12.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = "M-PESA STATEMENTS",
                    fontSize = 14.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.Black
                )
                Text(
                    text = "SEE ALL",
                    fontSize = 12.sp,
                    color = MpesaGreen
                )
            }
        }
        items(statements) { statement ->
            StatementRow(statement = statement)
        }
        item { Spacer(modifier = Modifier.height(16.dp)) }
    }
}


@Composable
private fun HomeTopBar() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 15.dp, vertical = 12.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Box(
            modifier = Modifier
                .size(40.dp)
                .clip(CircleShape)
                .background(Color.LightGray),
            contentAlignment = Alignment.Center
        ) {
            Icon(
                imageVector = Icons.Filled.Person,
                contentDescription = "Profile",
                modifier = Modifier.size(24.dp),
                tint = Grey
            )
        }
        Spacer(modifier = Modifier.weight(1f))
        IconButton(onClick = {}) {
            Icon(
                imageVector = Icons.Filled.Notifications,
                contentDescription = "Notifications",
                modifier = Modifier.size(24.dp),
                tint = Grey
            )
        }
        IconButton(onClick = {}) {
            Text(text = "QR", fontSize = 16.sp, fontWeight = FontWeight.Bold, color = Grey)
        }
    }
}


@Composable
private fun BalanceSection(visible: Boolean, onToggle: () -> Unit) {
    Column(
        modifier = Modifier.fillMaxWidth().padding(horizontal = 15.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(text = "BALANCE", fontSize = 16.sp, color = Grey)
        Spacer(modifier = Modifier.height(4.dp))
        Row(verticalAlignment = Alignment.CenterVertically) {
            Text(
                text = if (visible) "KSH. 2,456" else "KSH. ****",
                fontSize = 22.sp,
                fontWeight = FontWeight.Bold,
                color = Color.Black
            )
            Spacer(modifier = Modifier.width(8.dp))
            Text(
                text = if (visible) "HIDE" else "SHOW",
                fontSize = 12.sp,
                color = MpesaGreen,
                modifier = Modifier.clickable { onToggle() }
            )
        }
    }
}


@Composable
private fun QuickActionRow() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 15.dp, vertical = 16.dp),
        horizontalArrangement = Arrangement.SpaceEvenly
    ) {
        QuickActionButton(icon = Icons.Filled.Share, label = "SEND", bgColor = MpesaGreen, iconColor = White)
        QuickActionButton(icon = Icons.Filled.ShoppingCart, label = "PAY", bgColor = ActionBlue, iconColor = White)
        QuickActionTextButton(text = "W", label = "WITHDRAW", bgColor = ActionRed)
        QuickActionButton(icon = Icons.Filled.Phone, label = "AIRTIME", bgColor = ActionLightBlue, iconColor = White)
    }
}

@Composable
private fun QuickActionButton(
    icon: ImageVector,
    label: String,
    bgColor: Color,
    iconColor: Color
) {
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Box(
            modifier = Modifier
                .size(40.dp)
                .clip(CircleShape)
                .background(bgColor),
            contentAlignment = Alignment.Center
        ) {
            Icon(
                imageVector = icon,
                contentDescription = label,
                modifier = Modifier.size(20.dp),
                tint = iconColor
            )
        }
        Spacer(modifier = Modifier.height(4.dp))
        Text(text = label, fontSize = 11.sp, textAlign = TextAlign.Center, color = Color.Black)
    }
}

@Composable
private fun QuickActionTextButton(text: String, label: String, bgColor: Color) {
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Box(
            modifier = Modifier
                .size(40.dp)
                .clip(CircleShape)
                .background(bgColor),
            contentAlignment = Alignment.Center
        ) {
            Text(text = text, fontSize = 16.sp, fontWeight = FontWeight.Bold, color = White)
        }
        Spacer(modifier = Modifier.height(4.dp))
        Text(text = label, fontSize = 11.sp, textAlign = TextAlign.Center, color = Color.Black)
    }
}


@OptIn(ExperimentalFoundationApi::class)
@Composable
private fun SpendingCardsPager(
    cards: List<PreviewCardInfo>,
    currentPage: Int,
    onPageChange: (Int) -> Unit
) {
    val pagerState = rememberPagerState(pageCount = { cards.size })

    LaunchedEffect(currentPage) { pagerState.animateScrollToPage(currentPage) }
    LaunchedEffect(pagerState.currentPage) { onPageChange(pagerState.currentPage) }

    Column {
        HorizontalPager(
            state = pagerState,
            contentPadding = PaddingValues(horizontal = 15.dp),
            modifier = Modifier.fillMaxWidth()
        ) { page ->
            val card = cards[page]
            val brush = when (card.bgIndex) {
                0 -> Brush.verticalGradient(listOf(CardGradientPink, CardGradientOrange, CardGradientBlue))
                1 -> Brush.verticalGradient(listOf(CardSolidOrange, CardSolidOrange))
                2 -> Brush.verticalGradient(listOf(CardSolidBlue, CardSolidBlue))
                else -> Brush.verticalGradient(listOf(CardSolidPink, CardSolidPink))
            }
            SpendingCard(card = card, brush = brush)
        }

        // Circle page indicator
        Row(
            modifier = Modifier.fillMaxWidth().padding(vertical = 12.dp),
            horizontalArrangement = Arrangement.Center
        ) {
            repeat(cards.size) { index ->
                Box(
                    modifier = Modifier
                        .padding(horizontal = 3.dp)
                        .size(if (index == pagerState.currentPage) 8.dp else 6.dp)
                        .clip(CircleShape)
                        .background(if (index == pagerState.currentPage) CardGradientOrange else Grey)
                )
            }
        }
    }
}

@Composable
private fun SpendingCard(card: PreviewCardInfo, brush: Brush) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .height(200.dp)
            .padding(horizontal = 4.dp),
        shape = RoundedCornerShape(12.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
    ) {
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(brush)
                .padding(12.dp)
        ) {
            Column(modifier = Modifier.fillMaxSize()) {
                Text(text = card.mainTitle, fontSize = 10.sp, color = Color(0xFFCAC8C8))
                Spacer(modifier = Modifier.height(4.dp))
                Text(text = card.mainAmount, fontSize = 20.sp, fontWeight = FontWeight.Bold, color = White)
                Spacer(modifier = Modifier.weight(1f))
                Text(text = card.subTitle, fontSize = 14.sp, color = Color(0xFFE6E5E5))
                Text(text = card.subAmount, fontSize = 14.sp, color = White)
            }
            Surface(
                modifier = Modifier.align(Alignment.TopEnd),
                shape = RoundedCornerShape(50),
                color = TranslucentBlack
            ) {
                Text(
                    text = "MY SPEND",
                    modifier = Modifier.padding(horizontal = 16.dp, vertical = 6.dp),
                    fontSize = 11.sp,
                    color = White
                )
            }
            Text(
                text = card.cardLabel,
                fontSize = 14.sp,
                fontWeight = FontWeight.Bold,
                color = White.copy(alpha = 0.7f),
                modifier = Modifier.align(Alignment.BottomEnd)
            )
        }
    }
}


@Composable
private fun StatementRow(statement: PreviewStatement) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 15.dp, vertical = 7.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Box(
            modifier = Modifier
                .size(50.dp)
                .clip(CircleShape)
                .background(AvatarBg)
                .border(3.dp, White, CircleShape),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = statement.initials,
                fontSize = 14.sp,
                fontWeight = FontWeight.Bold,
                color = Color(0xFFBBDEFB)
            )
        }
        Column(modifier = Modifier.padding(start = 16.dp).weight(1f)) {
            Text(text = statement.shopName, fontSize = 12.sp, fontWeight = FontWeight.Bold, color = Color.Black)
            Text(text = statement.transactionId, fontSize = 11.sp, color = Grey)
        }
        Column(horizontalAlignment = Alignment.End) {
            Text(text = statement.amount, fontSize = 12.sp, fontWeight = FontWeight.Bold, color = Color.Black, textAlign = TextAlign.End)
            Text(text = statement.transactionDate, fontSize = 11.sp, color = Grey)
        }
    }
}


@Composable
private fun PlaceholderScreen(screen: MpesaScreen) {
    Box(
        modifier = Modifier.fillMaxSize().background(White),
        contentAlignment = Alignment.Center
    ) {
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Icon(
                imageVector = screen.icon,
                contentDescription = null,
                modifier = Modifier.size(48.dp),
                tint = Grey
            )
            Spacer(modifier = Modifier.height(12.dp))
            Text(text = screen.label, fontSize = 20.sp, color = Grey)
            Spacer(modifier = Modifier.height(4.dp))
            Text(text = "Hello blank fragment", fontSize = 14.sp, color = Grey)
        }
    }
}


@Composable
private fun BottomNavBar(
    currentScreen: MpesaScreen,
    onScreenChange: (MpesaScreen) -> Unit
) {
    val tabs = listOf(MpesaScreen.Home, MpesaScreen.Transact, MpesaScreen.Discover, MpesaScreen.Growth)

    NavigationBar(containerColor = White) {
        tabs.forEach { screen ->
            NavigationBarItem(
                selected = currentScreen == screen,
                onClick = { onScreenChange(screen) },
                icon = {
                    Icon(
                        imageVector = screen.icon,
                        contentDescription = screen.label,
                        modifier = Modifier.size(24.dp)
                    )
                },
                label = { Text(text = screen.label, fontSize = 11.sp) }
            )
        }
    }
}


@Composable
private fun StaticBottomNav(selected: MpesaScreen) {
    val tabs = listOf(MpesaScreen.Home, MpesaScreen.Transact, MpesaScreen.Discover, MpesaScreen.Growth)
    NavigationBar(containerColor = White) {
        tabs.forEach { screen ->
            NavigationBarItem(
                selected = screen == selected,
                onClick = {},
                icon = {
                    Icon(
                        imageVector = screen.icon,
                        contentDescription = screen.label,
                        modifier = Modifier.size(24.dp)
                    )
                },
                label = { Text(text = screen.label, fontSize = 11.sp) }
            )
        }
    }
}

@Preview(name = "2-Home", showBackground = true, widthDp = 412, heightDp = 892)
@Composable
private fun PreviewHome() {
    MaterialTheme {
        Scaffold(bottomBar = { StaticBottomNav(MpesaScreen.Home) }) { innerPadding ->
            Box(modifier = Modifier.padding(innerPadding)) {
                HomeScreen(
                    balanceVisible = true,
                    onToggleBalance = {},
                    currentCardPage = 0,
                    onCardPageChange = {}
                )
            }
        }
    }
}

