package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.Menu
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material.icons.filled.Warning
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 1. Enable Edge-to-Edge
        enableEdgeToEdge()

        // 2. Hide System Bars for Immersive Mode
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            AeroSenseApp()
        }
    }
}

// --- Theme & Colors ---
val PureWhite = Color(0xFFFFFFFF)
val OffWhite = Color(0xFFFAFAFA)
val TextPrimary = Color(0xFF1A1A1A)
val TextSecondary = Color(0xFF757575)
val AccentGreen = Color(0xFF4CAF50)
val AccentWarning = Color(0xFFFF9800)
val DividerColor = Color(0xFFEEEEEE)

private val LightColorScheme = lightColorScheme(
    primary = TextPrimary,
    onPrimary = PureWhite,
    background = PureWhite,
    surface = PureWhite,
    onBackground = TextPrimary,
    onSurface = TextPrimary,
)

// --- Main Composable ---
@Composable
fun AeroSenseApp() {
    MaterialTheme(colorScheme = LightColorScheme) {
        Scaffold(
            containerColor = PureWhite,
            topBar = { TopHeader() },
            bottomBar = { BottomControlBar() }
        ) { innerPadding ->
            MainContent(padding = innerPadding)
        }
    }
}

@Composable
fun TopHeader() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 24.dp, vertical = 24.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Column {
            Text(
                text = "Living Room",
                style = MaterialTheme.typography.titleMedium,
                color = TextSecondary,
                fontWeight = FontWeight.Normal
            )
            Text(
                text = "AeroSense",
                style = MaterialTheme.typography.headlineMedium,
                color = TextPrimary,
                fontWeight = FontWeight.Bold
            )
        }
        IconButton(
            onClick = { /* No op */ },
            modifier = Modifier
                .background(OffWhite, CircleShape)
                .size(48.dp)
        ) {
            Icon(Icons.Filled.Settings, contentDescription = "Settings", tint = TextPrimary)
        }
    }
}

@Composable
fun MainContent(padding: PaddingValues) {
    LazyColumn(
        modifier = Modifier
            .fillMaxSize()
            .padding(padding),
        contentPadding = PaddingValues(horizontal = 24.dp, vertical = 16.dp),
        verticalArrangement = Arrangement.spacedBy(32.dp)
    ) {
        // 1. Main Air Quality Indicator
        item {
            AirQualityCircle(aqi = 42)
        }

        // 2. Metrics Grid
        item {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                MetricCard(
                    modifier = Modifier.weight(1f),
                    label = "Temp",
                    value = "23°C",
                    icon = Icons.Filled.Info, // Generic icon as standard lib is limited
                    statusColor = TextPrimary
                )
                MetricCard(
                    modifier = Modifier.weight(1f),
                    label = "Humidity",
                    value = "45%",
                    icon = Icons.Filled.Check, // Check implies good level
                    statusColor = AccentGreen
                )
            }
            Spacer(modifier = Modifier.height(16.dp))
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                MetricCard(
                    modifier = Modifier.weight(1f),
                    label = "PM 2.5",
                    value = "12",
                    icon = Icons.Filled.CheckCircle,
                    statusColor = AccentGreen
                )
                MetricCard(
                    modifier = Modifier.weight(1f),
                    label = "CO2",
                    value = "850",
                    icon = Icons.Filled.Warning,
                    statusColor = AccentWarning
                )
            }
        }

        // 3. Status Message
        item {
            StatusBanner()
        }
    }
}

@Composable
fun AirQualityCircle(aqi: Int) {
    Box(
        contentAlignment = Alignment.Center,
        modifier = Modifier
            .fillMaxWidth()
            .aspectRatio(1.2f)
    ) {
        // Custom Drawing for the Indicator Ring
        Canvas(modifier = Modifier.size(220.dp)) {
            // Background Track
            drawArc(
                color = OffWhite,
                startAngle = 135f,
                sweepAngle = 270f,
                useCenter = false,
                style = Stroke(width = 40f, cap = StrokeCap.Round)
            )
            // Progress Track (Calculated roughly for AQI 42/100)
            drawArc(
                color = AccentGreen,
                startAngle = 135f,
                sweepAngle = 110f, // 40% of 270
                useCenter = false,
                style = Stroke(width = 40f, cap = StrokeCap.Round)
            )
            // Decor dots
            drawCircle(
                color = PureWhite,
                radius = 12f,
                center = center + Offset(
                    x = (size.width / 2) * 0.7f, // rough math for visual pos
                    y = (size.height / 2) * 0.7f
                )
            )
        }

        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Text(
                text = "AQI",
                style = MaterialTheme.typography.labelLarge,
                color = TextSecondary,
                fontWeight = FontWeight.Bold,
                letterSpacing = 2.sp
            )
            Text(
                text = "$aqi",
                style = MaterialTheme.typography.displayLarge,
                fontSize = 80.sp,
                color = TextPrimary,
                fontWeight = FontWeight.Medium
            )
            Text(
                text = "Excellent",
                style = MaterialTheme.typography.titleMedium,
                color = AccentGreen,
                modifier = Modifier
                    .background(AccentGreen.copy(alpha = 0.1f), RoundedCornerShape(16.dp))
                    .padding(horizontal = 12.dp, vertical = 6.dp)
            )
        }
    }
}

@Composable
fun MetricCard(
    modifier: Modifier = Modifier,
    label: String,
    value: String,
    icon: ImageVector,
    statusColor: Color
) {
    Card(
        modifier = modifier.height(110.dp),
        shape = RoundedCornerShape(24.dp),
        colors = CardDefaults.cardColors(containerColor = OffWhite),
        elevation = CardDefaults.cardElevation(defaultElevation = 0.dp)
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(16.dp),
            verticalArrangement = Arrangement.SpaceBetween
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Icon(
                    imageVector = icon,
                    contentDescription = null,
                    tint = statusColor,
                    modifier = Modifier.size(20.dp)
                )
            }
            Column {
                Text(
                    text = value,
                    style = MaterialTheme.typography.headlineSmall,
                    fontWeight = FontWeight.SemiBold,
                    color = TextPrimary
                )
                Text(
                    text = label,
                    style = MaterialTheme.typography.bodySmall,
                    color = TextSecondary
                )
            }
        }
    }
}

@Composable
fun StatusBanner() {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .border(1.dp, DividerColor, RoundedCornerShape(20.dp))
            .padding(20.dp)
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            Icon(
                Icons.Filled.Home,
                contentDescription = null,
                tint = TextPrimary,
                modifier = Modifier.size(24.dp)
            )
            Spacer(modifier = Modifier.width(12.dp))
            Text(
                text = "Room Analysis",
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.Bold
            )
        }
        Spacer(modifier = Modifier.height(12.dp))
        Text(
            text = "Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.",
            style = MaterialTheme.typography.bodyMedium,
            color = TextSecondary,
            lineHeight = 22.sp
        )
    }
}

@Composable
fun BottomControlBar() {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .background(PureWhite)
    ) {
        HorizontalDivider(color = DividerColor)
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(24.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            ControlIcon(Icons.Filled.Menu, "Menu")

            Button(
                onClick = { /* No op */ },
                colors = ButtonDefaults.buttonColors(
                    containerColor = TextPrimary,
                    contentColor = PureWhite
                ),
                shape = RoundedCornerShape(16.dp),
                contentPadding = PaddingValues(horizontal = 24.dp, vertical = 16.dp)
            ) {
                Icon(Icons.Filled.Refresh, contentDescription = null, modifier = Modifier.size(18.dp))
                Spacer(modifier = Modifier.width(8.dp))
                Text("Refresh Data")
            }

            ControlIcon(Icons.Filled.Add, "Add Room")
        }
    }
}

@Composable
fun ControlIcon(icon: ImageVector, desc: String) {
    IconButton(
        onClick = { /* No op */ },
        modifier = Modifier
            .size(48.dp)
            .border(1.dp, DividerColor, CircleShape)
    ) {
        Icon(icon, contentDescription = desc, tint = TextPrimary)
    }
}

// Utility extension for cleaner Modifier code if needed (inline usage preferred for single file)


@Preview(showBackground = true, widthDp = 380, heightDp = 800)
@Composable
fun AppPreview() {
    AeroSenseApp()
}