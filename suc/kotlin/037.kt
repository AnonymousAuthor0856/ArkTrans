package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.BottomAppBar
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
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
import java.text.NumberFormat

private const val NAME = "448_BudgetPie_en"
private const val UI_TYPE = "Finance"
private const val STYLE_THEME = "Cold Gradient"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF4A5568)
        val secondary = Color(0xFF718096)
        val tertiary = Color(0xFFA0AEC0)
        val background = Color(0xFFF7FAFC)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFEDF2F7)
        val outline = Color(0xFFE2E8F0)
        val success = Color(0xFF48BB78)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFF56565)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFF1A202C)
        val onBackground = Color(0xFF1A202C)
        val onSurface = Color(0xFF1A202C)

        val gradient1 = Brush.verticalGradient(listOf(Color(0xFF63B3ED), Color(0xFF4299E1)))
        val gradient2 = Brush.verticalGradient(listOf(Color(0xFF4FD1C5), Color(0xFF38B2AC)))
        val gradient3 = Brush.verticalGradient(listOf(Color(0xFF667EEA), Color(0xFF5A67D8)))
        val gradient4 = Brush.verticalGradient(listOf(Color(0xFFED64A6), Color(0xFFD53F8C)))
        val gradient5 = Brush.verticalGradient(listOf(Color(0xFFF6AD55), Color(0xFFED8936)))
    }

    object TypographyTokens {
        val display = TextStyle(fontSize = 36.sp, fontWeight = FontWeight.Bold, letterSpacing = (-0.5).sp)
        val headline = TextStyle(fontSize = 24.sp, fontWeight = FontWeight.SemiBold, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Normal, letterSpacing = 0.sp)
        val label = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium, letterSpacing = 0.5.sp)
    }

    object Shapes {
        val small = RoundedCornerShape(4.dp)
        val medium = RoundedCornerShape(8.dp)
        val large = RoundedCornerShape(16.dp)
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
        val level2 = ShadowSpec(4.dp, 6.dp, 2.dp, 0.07f)
        val level3 = ShadowSpec(8.dp, 15.dp, 5.dp, 0.10f)
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
    outline = AppTokens.Colors.outline
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

data class BudgetItem(
    val name: String,
    val value: Double,
    val brush: Brush
)

val budgetData = listOf(
    BudgetItem("Housing", 1250.00, AppTokens.Colors.gradient1),
    BudgetItem("Food", 480.50, AppTokens.Colors.gradient2),
    BudgetItem("Transport", 210.75, AppTokens.Colors.gradient3),
    BudgetItem("Entertainment", 150.00, AppTokens.Colors.gradient4),
    BudgetItem("Utilities", 320.00, AppTokens.Colors.gradient5)
)

@Composable
fun PieChart(
    items: List<BudgetItem>,
    modifier: Modifier = Modifier,
    strokeWidth: Dp = 20.dp
) {
    val totalValue = items.sumOf { it.value }
    var startAngle = -90f

    Box(modifier = modifier, contentAlignment = Alignment.Center) {
        Canvas(modifier = Modifier.fillMaxSize()) {
            items.forEach { item ->
                val sweepAngle = (item.value / totalValue * 360).toFloat()
                drawArc(
                    brush = item.brush,
                    startAngle = startAngle,
                    sweepAngle = sweepAngle,
                    useCenter = false,
                    style = Stroke(width = strokeWidth.toPx(), cap = StrokeCap.Butt),
                    size = Size(size.width, size.height)
                )
                startAngle += sweepAngle
            }
        }
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
             Text(
                text = "Total Spent",
                style = MaterialTheme.typography.labelMedium,
                color = AppTokens.Colors.secondary
            )
            Text(
                text = formatCurrency(totalValue),
                style = MaterialTheme.typography.headlineMedium,
                color = AppTokens.Colors.primary
            )
        }
    }
}

@Composable
fun BudgetItemRow(item: BudgetItem) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = AppTokens.Spacing.md, horizontal = AppTokens.Spacing.md),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)) {
            Box(modifier = Modifier
                .size(20.dp)
                .background(item.brush, CircleShape))
            Text(text = item.name, style = MaterialTheme.typography.bodyMedium, color = AppTokens.Colors.onSurface)
        }
        Text(text = formatCurrency(item.value), style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.onSurface)
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        containerColor = AppTokens.Colors.background,
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Monthly Budget", style = MaterialTheme.typography.headlineMedium, color = AppTokens.Colors.primary) }
            )
        },
        floatingActionButton = {
            FloatingActionButton(
                onClick = { /* Add new expense */ },
                containerColor = AppTokens.Colors.primary,
                contentColor = AppTokens.Colors.onPrimary,
                shape = CircleShape
            ) {
                 Text("+", style = MaterialTheme.typography.headlineMedium)
            }
        },
        bottomBar = {
            BottomAppBar(
                containerColor = AppTokens.Colors.surface,
                tonalElevation = AppTokens.ElevationMapping.level3.elevation,
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = AppTokens.Spacing.sm),
                    horizontalArrangement = Arrangement.SpaceAround,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    BottomBarItem(text = "Home", active = true)
                    BottomBarItem(text = "Reports", active = false)
                    Spacer(Modifier.width(AppTokens.Spacing.xl)) 
                    BottomBarItem(text = "Goals", active = false)
                    BottomBarItem(text = "Settings", active = false)
                }
            }
        }
    ) { padding ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(horizontal = AppTokens.Spacing.lg),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
        ) {
            item {
                PieChart(
                    items = budgetData,
                    modifier = Modifier.size(240.dp)
                )
                Spacer(modifier = Modifier.height(AppTokens.Spacing.lg))
            }
            items(budgetData) { item ->
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    shape = AppTokens.Shapes.large,
                    colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                    elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation)
                ) {
                    BudgetItemRow(item = item)
                }
            }
            item {
                Spacer(modifier = Modifier.height(AppTokens.Spacing.xxl))
            }
        }
    }
}

@Composable
fun BottomBarItem(text: String, active: Boolean) {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
    ) {
        val color = if (active) AppTokens.Colors.primary else AppTokens.Colors.tertiary
        Box(
            modifier = Modifier
                .size(24.dp)
                .background(color.copy(alpha = 0.2f), CircleShape)
        )
        Text(
            text = text,
            style = MaterialTheme.typography.labelMedium,
            color = color,
            textAlign = TextAlign.Center
        )
    }
}


private fun formatCurrency(value: Double): String {
    return NumberFormat.getCurrencyInstance(java.util.Locale.US).apply {
        maximumFractionDigits = 2
    }.format(value)
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
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
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

@Preview(showBackground = true, widthDp = 360, heightDp = 740)
@Composable
fun DefaultPreview() {
    AppTheme {
        RootScreen()
    }
}
