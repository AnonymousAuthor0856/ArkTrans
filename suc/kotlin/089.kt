package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
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
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Build
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.Lock
import androidx.compose.material.icons.filled.Menu
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material.icons.filled.Warning
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Divider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Switch
import androidx.compose.material3.SwitchDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
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

        // 2. Force Immersive Mode (Hide System Bars)
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            // Keep system bars hidden if the view redraws
            SideEffect {
                windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())
            }

            CryoGenApp()
        }
    }
}

// --- Theme Colors (Simple, High Contrast) ---
val PrimaryBlue = Color(0xFF0066CC)
val AlertRed = Color(0xFFD32F2F)
val SafeGreen = Color(0xFF388E3C)
val BackgroundWhite = Color(0xFFFFFFFF)
val SurfaceGrey = Color(0xFFF5F5F5)
val TextDark = Color(0xFF212121)
val TextGrey = Color(0xFF757575)

@Composable
fun CryoGenApp() {
    MaterialTheme(
        colorScheme = androidx.compose.material3.lightColorScheme(
            primary = PrimaryBlue,
            background = BackgroundWhite,
            surface = BackgroundWhite,
            onBackground = TextDark,
            onSurface = TextDark
        )
    ) {
        Scaffold(
            containerColor = BackgroundWhite,
            topBar = { SimpleTopBar() },
            bottomBar = { BottomControlBar() }
        ) { innerPadding ->
            // Main Content Area
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(innerPadding)
                    .padding(horizontal = 24.dp)
            ) {
                Spacer(modifier = Modifier.height(16.dp))

                // Status Header
                SystemStatusBadge()

                Spacer(modifier = Modifier.height(32.dp))

                // Big Temperature Display
                MainTemperatureDisplay()

                Spacer(modifier = Modifier.height(32.dp))

                // Grid of Sensor Cards
                SensorGrid()

                Spacer(modifier = Modifier.height(24.dp))

                // Activity Log Title
                Text(
                    text = "MAINTENANCE LOG",
                    fontSize = 12.sp,
                    fontWeight = FontWeight.Bold,
                    color = TextGrey,
                    letterSpacing = 1.5.sp
                )
                Spacer(modifier = Modifier.height(8.dp))

                // Scrollable Log List
                ActivityLogList()
            }
        }
    }
}

// --- Components ---

@Composable
fun SimpleTopBar() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(top = 24.dp, bottom = 12.dp, start = 24.dp, end = 24.dp)
            .height(56.dp),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Column {
            Text(
                text = "UNIT-04",
                fontSize = 12.sp,
                fontWeight = FontWeight.Bold,
                color = TextGrey
            )
            Text(
                text = "CryoGen Monitor",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
                color = TextDark
            )
        }
        IconButton(onClick = { /* No-op */ }) {
            Icon(
                imageVector = Icons.Default.Settings,
                contentDescription = "Settings",
                tint = TextDark
            )
        }
    }
}

@Composable
fun SystemStatusBadge() {
    Row(
        verticalAlignment = Alignment.CenterVertically,
        modifier = Modifier
            .border(1.dp, SafeGreen.copy(alpha = 0.5f), RoundedCornerShape(50))
            .padding(horizontal = 12.dp, vertical = 6.dp)
    ) {
        Icon(
            imageVector = Icons.Default.Check,
            contentDescription = null,
            tint = SafeGreen,
            modifier = Modifier.size(16.dp)
        )
        Spacer(modifier = Modifier.width(8.dp))
        Text(
            text = "SYSTEM NOMINAL",
            color = SafeGreen,
            fontSize = 12.sp,
            fontWeight = FontWeight.Bold
        )
    }
}

@Composable
fun MainTemperatureDisplay() {
    Column(horizontalAlignment = Alignment.Start) {
        Text(
            text = "CORE TEMPERATURE",
            fontSize = 12.sp,
            color = TextGrey,
            fontWeight = FontWeight.Medium
        )
        Row(verticalAlignment = Alignment.Bottom) {
            Text(
                text = "-184.2",
                fontSize = 64.sp,
                fontWeight = FontWeight.Light,
                color = TextDark,
                letterSpacing = (-2).sp
            )
            Text(
                text = "°C",
                fontSize = 24.sp,
                fontWeight = FontWeight.Normal,
                color = TextGrey,
                modifier = Modifier.padding(bottom = 12.dp, start = 4.dp)
            )
        }
    }
}

@Composable
fun SensorGrid() {
    Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            SensorCard(
                title = "PRESSURE",
                value = "1.02",
                unit = "Bar",
                icon = Icons.Default.Info,
                modifier = Modifier.weight(1f)
            )
            SensorCard(
                title = "O2 LEVEL",
                value = "19.5",
                unit = "%",
                icon = Icons.Default.Warning,
                isWarning = true,
                modifier = Modifier.weight(1f)
            )
        }
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            SensorCard(
                title = "POWER",
                value = "Stable",
                unit = "AC",
                icon = Icons.Default.Build,
                modifier = Modifier.weight(1f)
            )
            SensorCard(
                title = "LIQUID N2",
                value = "88",
                unit = "%",
                icon = Icons.Default.Refresh, // Used as 'Cycle' or 'Flow'
                modifier = Modifier.weight(1f)
            )
        }
    }
}

@Composable
fun SensorCard(
    title: String,
    value: String,
    unit: String,
    icon: ImageVector,
    isWarning: Boolean = false,
    modifier: Modifier = Modifier
) {
    Card(
        modifier = modifier,
        shape = RoundedCornerShape(12.dp),
        colors = CardDefaults.cardColors(containerColor = SurfaceGrey),
        elevation = CardDefaults.cardElevation(defaultElevation = 0.dp)
    ) {
        Column(
            modifier = Modifier.padding(16.dp),
            verticalArrangement = Arrangement.SpaceBetween
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Icon(
                    imageVector = icon,
                    contentDescription = null,
                    tint = if (isWarning) AlertRed else PrimaryBlue,
                    modifier = Modifier.size(20.dp)
                )
                if (isWarning) {
                    Box(
                        modifier = Modifier
                            .size(6.dp)
                            .clip(CircleShape)
                            .background(AlertRed)
                    )
                }
            }
            Spacer(modifier = Modifier.height(12.dp))
            Column {
                Text(
                    text = value,
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold,
                    color = TextDark
                )
                Text(
                    text = "$unit  $title",
                    fontSize = 10.sp,
                    fontWeight = FontWeight.Bold,
                    color = TextGrey
                )
            }
        }
    }
}

@Composable
fun ActivityLogList() {
    val logs = listOf(
        LogEntry("08:00 AM", "Auto-Cycle Complete", true),
        LogEntry("07:45 AM", "Pressure stabilized", true),
        LogEntry("06:30 AM", "Technician access", false),
        LogEntry("02:15 AM", "Nitrogen refill", true),
        LogEntry("Yesterday", "System Reboot", true),
    )

    LazyColumn(
        modifier = Modifier.fillMaxSize(),
        verticalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        items(logs) { log ->
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(vertical = 4.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Box(
                    modifier = Modifier
                        .size(32.dp)
                        .clip(CircleShape)
                        .background(SurfaceGrey),
                    contentAlignment = Alignment.Center
                ) {
                    Icon(
                        imageVector = if (log.isSystem) Icons.Default.Refresh else Icons.Default.Person, // Person is not strictly "material.icons" but "Icons.Default" includes it usually, otherwise use Home/Info. Let's stick to safe ones.
                        // Actually Icons.Default.Home/Info/Settings/Warning are safest core icons.
                        // I will use Icons.Default.Info for system, Icons.Default.Build for manual.
                        
                        contentDescription = null,
                        tint = TextGrey,
                        modifier = Modifier.size(16.dp)
                    )
                }
                Spacer(modifier = Modifier.width(12.dp))
                Column {
                    Text(
                        text = log.message,
                        fontSize = 14.sp,
                        fontWeight = FontWeight.Medium,
                        color = TextDark
                    )
                    Text(
                        text = log.time,
                        fontSize = 11.sp,
                        color = TextGrey
                    )
                }
            }
            Divider(color = SurfaceGrey, thickness = 1.dp)
        }
    }
}

data class LogEntry(val time: String, val message: String, val isSystem: Boolean)

@Composable
fun BottomControlBar() {
    // A secure control panel at the bottom
    var isLocked by remember { mutableStateOf(true) }

    Surface(
        color = BackgroundWhite,
        shadowElevation = 12.dp,
        tonalElevation = 2.dp,
        modifier = Modifier.fillMaxWidth()
    ) {
        Row(
            modifier = Modifier
                .padding(24.dp)
                .fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Column {
                Text(
                    text = "MANUAL OVERRIDE",
                    fontSize = 10.sp,
                    fontWeight = FontWeight.Bold,
                    color = TextGrey
                )
                Text(
                    text = if (isLocked) "LOCKED" else "ACTIVE",
                    fontSize = 14.sp,
                    fontWeight = FontWeight.Bold,
                    color = if (isLocked) TextDark else AlertRed
                )
            }

            Switch(
                checked = !isLocked,
                onCheckedChange = { isLocked = !it },
                thumbContent = {
                    Icon(
                        imageVector = if (isLocked) Icons.Default.Lock else Icons.Default.Warning,
                        contentDescription = null,
                        modifier = Modifier.size(16.dp)
                    )
                },
                colors = SwitchDefaults.colors(
                    checkedThumbColor = BackgroundWhite,
                    checkedTrackColor = AlertRed,
                    uncheckedThumbColor = TextGrey,
                    uncheckedTrackColor = SurfaceGrey,
                    uncheckedBorderColor = Color.Transparent
                )
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    CryoGenApp()
}