package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "032_WalletDashFinance_en"
private const val UI_TYPE = "Finance/Wallet"
private const val STYLE_THEME = "Monochrome Comfortable"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF020617)
        val secondary = Color(0xFF4ADE80)
        val tertiary = Color(0xFF64748B)
        val background = Color(0xFFF8FAFC)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFF1F5F9)
        val outline = Color(0xFFE2E8F0)
        val success = Color(0xFF22C55E)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF020617)
        val onTertiary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFF020617)
        val onSurface = Color(0xFF020617)
    }

    object TypographyTokens {
        val display = TextStyle(fontSize = 48.sp, fontWeight = FontWeight.Bold, lineHeight = 56.sp, letterSpacing = (-0.5).sp)
        val headline = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.SemiBold, lineHeight = 36.sp)
        val title = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.Medium, lineHeight = 28.sp)
        val body = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Normal, lineHeight = 24.sp)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium, lineHeight = 16.sp, letterSpacing = 0.2.sp)
    }

    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(16.dp)
        val large = RoundedCornerShape(24.dp)
    }

    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 16.dp
        val lg = 24.dp
        val xl = 32.dp
        val xxl = 48.dp
    }

    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 3.dp, 1.dp, 0.05f)
        val level2 = ShadowSpec(4.dp, 8.dp, 2.dp, 0.08f)
        val level3 = ShadowSpec(8.dp, 12.dp, 4.dp, 0.10f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class Transaction(val id: Int, val name: String, val detail: String, val amount: String, val isCredit: Boolean)
data class ControlAction(val label: String)
data class NavItem(val label: String)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val transactions = remember {
        listOf(
            Transaction(1, "Spotify", "Subscription", "-$9.99", false),
            Transaction(2, "Income", "Monthly Salary", "+$2,500.00", true),
            Transaction(3, "Starbucks", "Coffee", "-$5.75", false),
            Transaction(4, "Amazon", "Shopping", "-$124.50", false),
            Transaction(5, "Refund", "Amazon Return", "+$32.00", true)
        )
    }
    val controlActions = remember { listOf(ControlAction("Send"), ControlAction("Receive"), ControlAction("Add"), ControlAction("More")) }
    val navItems = remember { listOf(NavItem("Home"), NavItem("Cards"), NavItem("Activity"), NavItem("Profile")) }
    val selectedNavItem = remember { mutableStateOf("Home") }

    Scaffold(
        contentWindowInsets = WindowInsets(0),
        containerColor = AppTokens.Colors.background,
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("My Wallet", style = MaterialTheme.typography.titleMedium) },
                navigationIcon = {
                    IconButton(onClick = {}) {
                        Box(modifier = Modifier.size(28.dp).background(AppTokens.Colors.surfaceVariant, CircleShape))
                    }
                },
                actions = {
                    IconButton(onClick = {}) {
                        Box(modifier = Modifier.size(28.dp).background(AppTokens.Colors.surfaceVariant, CircleShape))
                    }
                },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = Color.Transparent)
            )
        },
        bottomBar = {
            NavigationBar(
                containerColor = AppTokens.Colors.surface,
                tonalElevation = AppTokens.ElevationMapping.level3.elevation,
            ) {
                navItems.forEach { item ->
                    NavigationBarItem(
                        selected = selectedNavItem.value == item.label,
                        onClick = { selectedNavItem.value = item.label },
                        icon = {
                            Box(modifier = Modifier.size(24.dp).background(
                                if(selectedNavItem.value == item.label) AppTokens.Colors.primary else AppTokens.Colors.outline,
                                CircleShape)
                            )
                        },
                        label = { Text(item.label, style = MaterialTheme.typography.labelMedium) },
                        colors = NavigationBarItemDefaults.colors(
                            selectedIconColor = AppTokens.Colors.primary,
                            unselectedIconColor = AppTokens.Colors.tertiary,
                            selectedTextColor = AppTokens.Colors.primary,
                            unselectedTextColor = AppTokens.Colors.tertiary,
                            indicatorColor = AppTokens.Colors.surfaceVariant
                        )
                    )
                }
            }
        }
    ) { paddingValues ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(paddingValues),
            contentPadding = PaddingValues(horizontal = AppTokens.Spacing.md, vertical = AppTokens.Spacing.sm),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            item {
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    shape = AppTokens.Shapes.large,
                    colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.primary),
                    elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level2.elevation)
                ) {
                    Column(modifier = Modifier.padding(AppTokens.Spacing.lg)) {
                        Text(
                            "Total Balance",
                            style = MaterialTheme.typography.bodyMedium,
                            color = AppTokens.Colors.onPrimary.copy(alpha = 0.7f)
                        )
                        Spacer(modifier = Modifier.height(AppTokens.Spacing.sm))
                        Text(
                            "$ 1,145.14",
                            style = MaterialTheme.typography.displayLarge,
                            color = AppTokens.Colors.onPrimary
                        )
                        Spacer(modifier = Modifier.height(AppTokens.Spacing.xs))
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Box(modifier = Modifier.size(10.dp).background(AppTokens.Colors.secondary, CircleShape))
                            Spacer(modifier = Modifier.width(AppTokens.Spacing.sm))
                            Text("+$234.10 today", style = MaterialTheme.typography.bodyMedium, color = AppTokens.Colors.secondary)
                        }
                    }
                }
            }

            item {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceAround,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    controlActions.forEach { action ->
                        Column(
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                        ) {
                            Button(
                                onClick = {},
                                modifier = Modifier.size(64.dp),
                                shape = CircleShape,
                                colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.surface),
                                elevation = ButtonDefaults.buttonElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation),
                                contentPadding = PaddingValues(0.dp)
                            ) {
                                Box(modifier = Modifier.size(24.dp).background(AppTokens.Colors.primary, AppTokens.Shapes.small))
                            }
                            Text(action.label, style = MaterialTheme.typography.labelMedium)
                        }
                    }
                }
            }

            item {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text("Recent Activity", style = MaterialTheme.typography.titleMedium)
                    TextButton(onClick = {}) {
                        Text("View All", style = MaterialTheme.typography.labelMedium, color = AppTokens.Colors.tertiary)
                    }
                }
            }

            items(transactions) { transaction ->
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    shape = AppTokens.Shapes.medium,
                    colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                    border = BorderStroke(1.dp, AppTokens.Colors.outline)
                ) {
                    Row(
                        modifier = Modifier.padding(AppTokens.Spacing.md),
                        verticalAlignment = Alignment.CenterVertically,
                        horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                    ) {
                        Box(modifier = Modifier.size(48.dp).background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.medium))
                        Column(modifier = Modifier.weight(1f)) {
                            Text(transaction.name, style = MaterialTheme.typography.bodyMedium, fontWeight = FontWeight.SemiBold)
                            Text(transaction.detail, style = MaterialTheme.typography.labelMedium, color = AppTokens.Colors.tertiary)
                        }
                        Text(
                            transaction.amount,
                            style = MaterialTheme.typography.bodyMedium,
                            color = if (transaction.isCredit) AppTokens.Colors.success else AppTokens.Colors.onSurface,
                            fontWeight = FontWeight.SemiBold,
                            textAlign = TextAlign.End
                        )
                    }
                }
            }
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true, widthDp = 360, heightDp = 720)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}